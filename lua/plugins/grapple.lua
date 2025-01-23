local fmt = require("utils.icons").fmt

return {
	"cbochs/grapple.nvim",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", lazy = true },
	},
	cond = not vim.g.vscode,
	opts = {
		scope = "git",
	},
	event = { "BufReadPost", "BufNewFile" },
	cmd = "Grapple",
	keys = {
		{ "<leader>h", "<cmd>Grapple toggle<cr>",         desc = fmt("Hook", "Grapple toggle tag") },
		{ "<leader>l", "<cmd>Grapple toggle_tags<cr>",    desc = fmt("Hook", "Grapple open tags window") },
		{ "<leader>1", "<cmd>Grapple select index=1<cr>", desc = fmt("Hook", "Select first tag") },
		{ "<leader>2", "<cmd>Grapple select index=2<cr>", desc = fmt("Hook", "Select second tag") },
		{ "<leader>3", "<cmd>Grapple select index=3<cr>", desc = fmt("Hook", "Select third tag") },
		{ "<leader>4", "<cmd>Grapple select index=4<cr>", desc = fmt("Hook", "Select fourth tag") },
	},
}
