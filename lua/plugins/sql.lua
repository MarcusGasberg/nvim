return {
	{
		"kristijanhusak/vim-dadbod-ui",
		cond = not vim.g.vscode,
		dependencies = {
			{ "tpope/vim-dadbod",                     lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
		config = function()
			vim.g.db_ui_use_nerd_fonts = 1

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "sql",
				callback = function(event)
					require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
				end,
			})
		end,
	}
}
