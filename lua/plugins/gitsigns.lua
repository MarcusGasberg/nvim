local keymap = require("utils.keymap")
local fmt = require("utils.icons").fmt

return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cond = not vim.g.vscode,
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false,   -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false,  -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
		preview_config = {
			-- Options passed to nvim_open_win
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			keymap.normal_map("<leader>gb", function()
				gs.blame_line({ full = true })
			end, fmt("Git", "[GitSigns] Blame line"))
			keymap.normal_map("<leader>gh", function()
				gs.preview_hunk_inline()
			end, fmt("Git", "[GitSigns] Preview hunk"))
			keymap.normal_map("<leader>dt", function()
				gs.diffthis()
			end, fmt("Git", "[GitSigns] Diff this"))
			keymap.normal_map("<leader>gp", function()
				if vim.wo.diff then
					return "<leader>gp"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, fmt("Git", "[GitSigns] Previous hunk"))
			keymap.normal_map("<leader>gn", function()
				if vim.wo.diff then
					return "<leader>gn"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, fmt("Git", "[GitSigns] Next hunk"))
		end,
	}
}
