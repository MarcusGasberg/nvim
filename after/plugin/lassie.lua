-- Lassie: local AI code completion with ghost text
local ns = vim.api.nvim_create_namespace("lassie_ghost")
local daemon = "http://127.0.0.1:19876"
local timer = vim.uv.new_timer()
local debounce_ms = 500
local current_ghost = nil -- { bufnr, line, text }
local current_request = nil -- { sys = SystemObj, streaming = bool, row = int, bufnr = int }
local pending_refire = false -- fire a new request when the current stream finishes
local enabled = true

-- Cancel the in-flight request only if it hasn't started streaming yet.
-- Once tokens have arrived, let it finish and render what it has — otherwise
-- on a slow backend (e.g. CPU inference with multi-second prefill) rapid
-- typing cancels every request before any token reaches nvim.
local function cancel_inflight_if_unstarted()
  if current_request and not current_request.streaming then
    pcall(function() current_request.sys:kill(15) end) -- SIGTERM
    current_request = nil
  end
end

local function clear_ghost()
  if current_ghost then
    pcall(vim.api.nvim_buf_clear_namespace, current_ghost.bufnr, ns, 0, -1)
    current_ghost = nil
  end
end

local function show_ghost(bufnr, line, text)
  clear_ghost()
  if not text or text == "" then return end
  if not vim.api.nvim_buf_is_valid(bufnr) then return end

  -- Split into first line (inline) and remaining lines (below)
  local lines = vim.split(text, "\n", { plain = true })
  local virt_text = {{ lines[1], "Comment" }}
  local virt_lines = {}
  for i = 2, #lines do
    table.insert(virt_lines, {{ lines[i], "Comment" }})
  end

  local ok, err = pcall(vim.api.nvim_buf_set_extmark, bufnr, ns, line, -1, {
    virt_text = virt_text,
    virt_text_pos = "inline",
    virt_lines = #virt_lines > 0 and virt_lines or nil,
  })
  if not ok then
    vim.notify("[lassie] extmark error: " .. tostring(err), vim.log.levels.WARN)
    return
  end
  current_ghost = { bufnr = bufnr, line = line, text = text }
end

local function accept_ghost()
  if not current_ghost then return false end
  local bufnr = current_ghost.bufnr
  local line = current_ghost.line
  local text = current_ghost.text
  clear_ghost()

  local row = line
  local col = #vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]
  local lines = vim.split(text, "\n", { plain = true })
  vim.api.nvim_buf_set_text(bufnr, row, col, row, col, lines)

  -- Move cursor to end of inserted text
  local new_row = row + #lines - 1
  local new_col = (#lines == 1) and (col + #lines[1]) or #lines[#lines]
  vim.api.nvim_win_set_cursor(0, { new_row + 1, new_col })
  return true
end

local function find_project_root(file_path)
  local markers = vim.fs.find(
    { ".git", "pyproject.toml", "package.json", "Cargo.toml", "go.mod" },
    { upward = true, path = file_path }
  )
  if markers and markers[1] then
    return vim.fs.dirname(markers[1])
  end
  return vim.fn.getcwd()
end

local function request_completion(debug_mode)
  local bufnr = vim.api.nvim_get_current_buf()
  local pos = vim.api.nvim_win_get_cursor(0)
  local row, col = pos[1] - 1, pos[2]
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local content = table.concat(lines, "\n")

  -- Calculate byte offset
  local offset = 0
  for i = 1, row do
    offset = offset + #lines[i] + 1
  end
  offset = offset + col

  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local root = find_project_root(file_path)

  local body = vim.json.encode({
    file_path = file_path,
    content = content,
    cursor_offset = offset,
    project_root = root,
    max_tokens = 128,
  })

  if debug_mode then
    vim.notify("[lassie] requesting completion...\n  file: " .. file_path .. "\n  root: " .. root .. "\n  offset: " .. offset .. "\n  row: " .. row .. " col: " .. col, vim.log.levels.INFO)
  end

  cancel_inflight_if_unstarted()
  -- If a stream is already in flight (streaming=true), don't start another —
  -- the server serializes anyway and starting a duplicate would just cancel
  -- the one we're about to render. Remember we want to refire when it ends.
  if current_request and current_request.streaming then
    pending_refire = true
    return
  end

  local my_request
  local stdout_buf = ""
  local completion = ""

  -- Called for each SSE frame (a single "data: {json}" line).
  local function process_event(json_line)
    if json_line == "" then return end
    local ok, data = pcall(vim.json.decode, json_line)
    if not ok or type(data) ~= "table" then return end

    if data.done then
      if debug_mode and data.timing then
        vim.notify("[lassie] done. timing=" .. vim.inspect(data.timing), vim.log.levels.INFO)
      end
      return
    end

    local token = data.token
    if not token or token == "" then return end
    completion = completion .. token

    -- Mark the request as "streaming" on the first token. From here on, new
    -- keystrokes do NOT cancel it — we let it finish so the user actually
    -- sees output even when they keep typing.
    if my_request and not my_request.streaming then
      my_request.streaming = true
    end

    -- Only render if this is still the current in-flight request and the
    -- user is still on the same line.
    if current_request ~= my_request then return end
    if not vim.api.nvim_buf_is_valid(bufnr) then return end
    if vim.api.nvim_get_current_buf() ~= bufnr then return end
    local cur = vim.api.nvim_win_get_cursor(0)
    if not debug_mode and cur[1] - 1 ~= row then return end
    show_ghost(bufnr, cur[1] - 1, completion)
  end

  -- vim.system streams stdout via this callback. SSE frames are separated
  -- by "\n\n"; chunks may split across frames, so we buffer.
  local on_stdout = vim.schedule_wrap(function(_, data)
    if not data or data == "" then return end
    stdout_buf = stdout_buf .. data
    while true do
      local sep_s, sep_e = stdout_buf:find("\n\n", 1, true)
      if not sep_s then break end
      local frame = stdout_buf:sub(1, sep_s - 1)
      stdout_buf = stdout_buf:sub(sep_e + 1)
      -- Each frame is expected to be a single "data: {json}" line.
      local json_line = frame:match("^data:%s*(.*)$")
      if json_line then process_event(json_line) end
    end
  end)

  local sys = vim.system(
    -- -N disables curl's output buffering so SSE events arrive as emitted.
    { "curl", "-sN", "-m", "30", daemon .. "/v1/complete?stream=true",
      "-H", "Content-Type: application/json", "-d", body },
    { text = true, stdout = on_stdout },
    vim.schedule_wrap(function(result)
      if current_request == my_request then
        current_request = nil
      else
        -- Superseded; drop.
        return
      end
      if debug_mode then
        vim.notify("[lassie] curl exit=" .. tostring(result.code)
          .. " final_len=" .. #completion
          .. (result.stderr and (" stderr=" .. result.stderr:sub(1, 200)) or ""),
          vim.log.levels.INFO)
      end
      if result.code ~= 0 and debug_mode then
        vim.notify("[lassie] curl failed (exit=" .. tostring(result.code) .. ")", vim.log.levels.ERROR)
      end
      -- If user typed while we were streaming, fire a fresh request now that
      -- the lock is free and the old one is done.
      if pending_refire and enabled then
        pending_refire = false
        if vim.fn.mode() == "i" then
          request_completion(false)
        end
      end
    end)
  )
  my_request = { sys = sys, streaming = false, row = row, bufnr = bufnr }
  current_request = my_request
end

local function schedule_completion()
  if not enabled then return end
  -- Only clear the ghost if we're not actively streaming — otherwise we'd
  -- erase the tokens the user is about to see. (The streaming callback
  -- will re-render on the next token, or the stale-check will drop it.)
  if not (current_request and current_request.streaming) then
    clear_ghost()
  end
  timer:stop()
  timer:start(debounce_ms, 0, vim.schedule_wrap(function()
    if vim.fn.mode() == "i" then
      request_completion(false)
    end
  end))
end

-- Auto-trigger on text changes in insert mode
vim.api.nvim_create_autocmd("TextChangedI", {
  callback = schedule_completion,
})

-- Clear ghost when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    timer:stop()
    pending_refire = false
    -- Kill even a streaming request — user has left insert mode, the ghost
    -- isn't useful anymore.
    if current_request then
      pcall(function() current_request.sys:kill(15) end)
      current_request = nil
    end
    clear_ghost()
  end,
})

-- Tab to accept ghost text, fall through if no ghost
vim.keymap.set("i", "<Tab>", function()
  if not accept_ghost() then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end, { desc = "Accept lassie ghost text or insert tab" })

-- Debug command: run a one-shot completion with verbose logging
vim.api.nvim_create_user_command("LassieDebug", function()
  vim.notify("[lassie] running debug completion request...", vim.log.levels.INFO)
  request_completion(true)
end, { desc = "Debug lassie completion" })

-- Toggle command
vim.api.nvim_create_user_command("LassieToggle", function()
  enabled = not enabled
  if not enabled then
    timer:stop()
    clear_ghost()
  end
  vim.notify("[lassie] " .. (enabled and "enabled" or "disabled"), vim.log.levels.INFO)
end, { desc = "Toggle lassie ghost text" })
