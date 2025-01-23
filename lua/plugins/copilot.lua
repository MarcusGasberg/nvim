local keymap = require("utils.keymap")
local fmt = require("utils.icons").fmt


return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	cond = not vim.g.vscode,
	config = function()
		keymap.normal_map("<leader>cpa", function()
			require("copilot.suggestion").toggle_auto_trigger()
		end, fmt("Copilot", "Toggle Copilot"))

		keymap.normal_map("<leader>cpo", function()
			require("copilot.panel").toggle()
		end, fmt("Copilot", "Toggle Copilot Panel"))
	end,
	opts = {
		panel = {
			enabled = true,
			auto_refresh = false,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				refresh = "gr",
				open = "<M-CR>",
			},
			layout = {
				position = "bottom", -- | top | left | right
				ratio = 0.4,
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = false,
			hide_during_completion = true,
			debounce = 75,
			keymap = {
				accept = "<M-l>",
				accept_word = false,
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		filetypes = {
			yaml = false,
			markdown = false,
			help = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
			["."] = false,
		},
		copilot_node_command = "node", -- Node.js version must be > 18.x
		server_opts_overrides = {},
	}
}
