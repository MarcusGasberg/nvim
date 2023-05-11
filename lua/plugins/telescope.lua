local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local entry_display = require("telescope.pickers.entry_display")
local utils = require("telescope.utils")
local state = require("telescope.actions.state")
local f = require("functions")
local u = require("functions.utils")
local transform_mod = require("telescope.actions.mt").transform_mod

local builtin = require("telescope.builtin")

local function live_grep()
	builtin.live_grep()
end

local function git_files()
	local ok = pcall(builtin.git_files)
	if not ok then
		require("telescope.builtin").find_files()
	end
end

local function buffers()
	builtin.buffers()
end

local function oldfiles()
	builtin.oldfiles()
end

local function git_commits()
	builtin.git_commits()
end

local function git_branches()
	builtin.git_branches()
end

local function grep_string()
	local word = vim.fn.expand("<cword>")
	builtin.grep_string()
	vim.api.nvim_feedkeys(word, "i", false)
end

local function git_files_string()
	local word = vim.fn.expand("<cword>")
	builtin.git_files()
	vim.api.nvim_feedkeys(word, "i", false)
end

local function git_files_string_visual()
	local text = u.get_visual_selection()
	if(text == nil) then return end
	vim.api.nvim_input("<esc>")
	if text[1] == nil then
		print("No appropriate visual selection found")
	else
		builtin.git_files()
		vim.api.nvim_input(text[1])
	end
end

local function grep_string_visual()
	local text = u.get_visual_selection()
	if(text == nil) then return end

	vim.api.nvim_input("<esc>")
	local firstText = text[1]
	if firstText == nil then
		print("No appropriate visual selection found")
	else
		builtin.grep_string()
		vim.api.nvim_input(firstText)
		vim.api.nvim_feedkeys(text, "i", false)
	end
end

local function current_buffer_fuzzy_find()
	require("telescope.builtin").current_buffer_fuzzy_find()
end

function make_entry.gen_from_git_stash(opts)
	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 10 },
			opts.show_branch and { width = 15 } or "",
			{ remaining = true },
		},
	})

	local make_display = function(entry)
		return displayer({
			{ entry.value, "TelescopeResultsLineNr" },
			opts.show_branch and { entry.branch_name, "TelescopeResultsIdentifier" } or "",
			entry.commit_info,
		})
	end

	return function(entry)
		if entry == "" then
			return nil
		end

		local splitted = utils.max_split(entry, ": ", 2)
		local stash_idx = splitted[1]
		local _, commit_branch_name = string.match(splitted[2], "^([WIP on|On]+) (.+)")
		local commit_info = splitted[3]

		local real_branch = u.get_branch_name()
		local escaped_commit_branch_name = u.escape_string(commit_branch_name)

		local search = string.find(real_branch, escaped_commit_branch_name)
		if search == nil then
			return nil
		end

		return {
			value = stash_idx,
			ordinal = commit_info,
			branch_name = commit_branch_name,
			commit_info = commit_info,
			display = make_display,
		}
	end
end

local stash_filter = function()
	local opts = { show_branch = false }
	opts.show_branch = vim.F.if_nil(opts.show_branch, true)
	opts.entry_maker = vim.F.if_nil(opts.entry_maker, make_entry.gen_from_git_stash(opts))

	pickers.new(opts, {
		prompt_title = "Git Stash",
		finder = finders.new_oneshot_job({ "git", "--no-pager", "stash", "list" }, opts),
		previewer = previewers.git_stash_diff.new(opts),
		sorter = conf.file_sorter(opts),
		attach_mappings = function()
			actions.select_default:replace(actions.git_apply_stash)
			return true
		end,
	}):find()
end

local function SeeCommitChangesInDiffview(prompt_bufnr)
	actions.close(prompt_bufnr)
	local value = state.get_selected_entry(prompt_bufnr).value
	vim.cmd("DiffviewOpen " .. value .. "~1.." .. value)
end

local function CheckoutAndRestore(prompt_bufnr)
	vim.cmd("Obsession")
	actions.git_checkout(prompt_bufnr)
	f.create_or_source_obsession()
end

local function CompareWithCurrentBranchInDiffview(prompt_bufnr)
	actions.close(prompt_bufnr)
	local value = state.get_selected_entry(prompt_bufnr).value
	vim.cmd("DiffviewOpen " .. value)
end

local function CopyTextFromPreview(prompt_bufnr)
	local selection = require("telescope.actions.state").get_selected_entry()
	local text = vim.fn.trim(selection["text"])
	vim.fn.setreg('"', text)
	actions.close(prompt_bufnr)
end

local function CopyCommitHash(prompt_bufnr)
	local selection = require("telescope.actions.state").get_selected_entry()
	vim.fn.setreg('"', selection.value)
	actions.close(prompt_bufnr)
end


local function multiopen(prompt_bufnr, method)
    local edit_file_cmd_map = {
        vertical = "vsplit",
        horizontal = "split",
        tab = "tabedit",
        default = "edit",
    }
    local edit_buf_cmd_map = {
        vertical = "vert sbuffer",
        horizontal = "sbuffer",
        tab = "tab sbuffer",
        default = "buffer",
    }
    local picker = state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 1 then
        require("telescope.pickers").on_close_prompt(prompt_bufnr)
        pcall(vim.api.nvim_set_current_win, picker.original_win_id)

        for i, entry in ipairs(multi_selection) do
            local filename, row, col

            if entry.path or entry.filename then
                filename = entry.path or entry.filename

                row = entry.row or entry.lnum
                col = vim.F.if_nil(entry.col, 1)
            elseif not entry.bufnr then
                local value = entry.value
                if not value then
                    return
                end

                if type(value) == "table" then
                    value = entry.display
                end

                local sections = vim.split(value, ":")

                filename = sections[1]
                row = tonumber(sections[2])
                col = tonumber(sections[3])
            end

            local entry_bufnr = entry.bufnr

            if entry_bufnr then
                if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
                    vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
                end
                local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
                pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
            else
                local command = i == 1 and "edit" or edit_file_cmd_map[method]
                if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                    filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
                    pcall(vim.cmd, string.format("%s %s", command, filename))
                end
            end

            if row and col then
                pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
            end
        end
    else
        actions["select_" .. method](prompt_bufnr)
    end
end

local custom_actions = transform_mod({
    multi_selection_open_vertical = function(prompt_bufnr)
        multiopen(prompt_bufnr, "vertical")
    end,
    multi_selection_open_horizontal = function(prompt_bufnr)
        multiopen(prompt_bufnr, "horizontal")
    end,
    multi_selection_open_tab = function(prompt_bufnr)
        multiopen(prompt_bufnr, "tab")
    end,
    multi_selection_open = function(prompt_bufnr)
        multiopen(prompt_bufnr, "default")
    end,
})

local function stopinsert(callback)
    return function(prompt_bufnr)
        vim.cmd.stopinsert()
        vim.schedule(function()
            callback(prompt_bufnr)
        end)
    end
end

local multi_open_mappings = {
    i = {
        ["<C-v>"] = stopinsert(custom_actions.multi_selection_open_vertical),
        ["<C-s>"] = stopinsert(custom_actions.multi_selection_open_horizontal),
        ["<C-t>"] = stopinsert(custom_actions.multi_selection_open_tab),
        ["<CR>"]  = stopinsert(custom_actions.multi_selection_open)
    },
    n = {
        ["<C-v>"] = custom_actions.multi_selection_open_vertical,
        ["<C-s>"] = custom_actions.multi_selection_open_horizontal,
        ["<C-t>"] = custom_actions.multi_selection_open_tab,
        ["<CR>"] = custom_actions.multi_selection_open,
    },
}

local live_grep_mappings = vim.tbl_deep_extend('keep', multi_open_mappings, {
  i = {
    ["<C-y>"] = CopyTextFromPreview,
  },
})

local telescope = require("telescope")
telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules", "package%-lock.json" },
		path_display = { "truncate" },
		mappings = {
			i = {
				["<C-j>"] = actions.cycle_history_next,
				["<C-k>"] = actions.cycle_history_prev,
      },
      n = {
				["<C-j>"] = actions.cycle_history_next,
				["<C-k>"] = actions.cycle_history_prev,
      }
		},
	},
	pickers = {
		live_grep = {
			only_sort_text = true,
			prompt_prefix = " ",
			mappings = live_grep_mappings,
		},
		git_branches = {
			prompt_prefix = " ",
			mappings = {
				i = {
					["<C-o>"] = CheckoutAndRestore,
					["<Enter>"] = CheckoutAndRestore,
				},
			},
		},
    git_files = {
      prompt_prefix = " ",
      mappings = multi_open_mappings
    },
		oldfiles = {
			prompt_prefix = " ",
			mappings = multi_open_mappings
		},
		grep_string = {
			prompt_prefix = " ",
		},
		current_buffer_fuzzy_find = {
			previewer = false,
			sorting_strategy = "ascending",
			prompt_prefix = " ",
		},
		buffers = {
			hidden = true,
			show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-x>"] = actions.delete_buffer,
        }
      }
		},
		git_commits = {
			prompt_prefix = " ",
			mappings = {
				i = {
					["<C-y>"] = CopyCommitHash,
					["<C-o>"] = SeeCommitChangesInDiffview,
					["<CR>"] = CompareWithCurrentBranchInDiffview,
				},
			},
		},

	},
	extensions = {
			fzf = {
				fuzzy = true,
				override_generic_sorter = true,
				override_file_sorter = true,
				case_mode = "smart_case",
			},
	file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
    },
  },
})
vim.g.fzf_history_dir = '~/.local/share/fzf-history'
telescope.load_extension("file_browser")
telescope.load_extension("fzf")

vim.keymap.set("n", "<leader>tr", oldfiles, {})
vim.keymap.set("n", "<leader>tgc", git_commits, {})
vim.keymap.set("n", "<leader>tgb", git_branches, {})
vim.keymap.set("n", "<leader>tf", grep_string, {})
vim.keymap.set("n", "<leader>h", live_grep, {})
vim.keymap.set("n", "<leader>j", git_files, {})
vim.keymap.set('n', '<leader>k', function()
	buffers()
end)
vim.keymap.set('n', '<leader>th', function()
  builtin.help_tags()
end)
vim.keymap.set('n', '<leader><leader>', function()
  builtin.resume()
end)
vim.keymap.set('n', '<leader>e', function()
  builtin.diagnostics()
end)
-- vim.keymap.set("n", "<leader>tf", git_files_string, {})
-- vim.keymap.set("v", "<leader>tf", git_files_string_visual, {})
vim.keymap.set("v", "<leader>tf", grep_string_visual, {})
vim.keymap.set("n", "<leader>tgs", stash_filter, {})


local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end
vim.keymap.set("n", '\\', function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    select_buffer=false,
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 }
  })
end)
