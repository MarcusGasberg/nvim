vim.g.db_ui_use_nerd_fonts = 1

vim.api.nvim_create_autocmd("FileType", {
	pattern = "sql",
	callback = function(event)
		require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
	end,
})
