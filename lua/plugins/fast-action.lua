return {
	"Chaitanyabsprip/fastaction.nvim",
	cond = not vim.g.vscode,
	opts = {
		signs = {
			enable = false,
		},
		dismiss_keys = { "j", "k", "<esc>", "q" },
		popup = {
			hide_cursor = true,
			border = "rounded",
		},
	},
}
