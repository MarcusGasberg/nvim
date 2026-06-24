-- nvim/lua/utils/claude_diagnostic.lua
local M = {}

-- Send the current line (with its diagnostics summarized) to Claude as context.
function M.send_current_line()
  local lnum = vim.api.nvim_win_get_cursor(0)[1]
  local diags = vim.diagnostic.get(0, { lnum = lnum - 1 })
  if vim.tbl_isempty(diags) then
    vim.notify("No diagnostics on this line", vim.log.levels.INFO)
    return
  end

  -- Set the '< '> marks to the current line, then run the range-aware send command.
  vim.cmd("normal! V")
  vim.cmd("normal! \27") -- <Esc> commits the visual marks
  vim.cmd("'<,'>ClaudeCodeSend")

  local msgs = {}
  for _, d in ipairs(diags) do
    table.insert(msgs, d.message)
  end
  vim.notify("Sent line to Claude. Fix: " .. table.concat(msgs, " | "), vim.log.levels.INFO)
end

return M
