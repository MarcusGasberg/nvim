local fmt = require('utils.icons').fmt;

return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cond = not vim.g.vscode,
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = fmt("Fix", "[Trouble] Diagnostics"),
		},
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = fmt("Fix", "[Trouble] Buffer Diagnostics"),
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = fmt("Fix", "[Trouble] Symbols"),
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = fmt("Fix", "[Trouble] LSP Definitions / references / ..."),
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = fmt("Fix", "[Trouble] Location List"),
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = fmt("Fix", "[Trouble] Quickfix List"),
		},
	},
	opts = {},
}
