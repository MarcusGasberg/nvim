local diffview = require("diffview")

return {
	setup = function()
		vim.keymap.set("n", "<leader>dfh", ":DiffviewFileHistory<CR>")
		vim.keymap.set("n", "<leader>dfo", ":DiffviewOpen<CR>")
		vim.keymap.set("n", "<leader>dfc", ":DiffviewClose<CR>")
		vim.keymap.set("n", "<Leader>gdh", ":diffget //2<CR>")
		vim.keymap.set("n", "<Leader>gdl", ":diffget //3<CR>")

		diffview.setup()
	end,
}
