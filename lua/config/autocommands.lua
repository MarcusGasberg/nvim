-- Highlight after yank
vim.cmd([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='Visual', timeout=300 }
  augroup END
]])

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
	pattern = { "*.component.html" },
	callback = function()
		vim.bo.filetype = "htmlangular"
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		-- try_lint without arguments runs the linters defined in `linters_by_ft`
		-- for the current filetype
		require("lint").try_lint()
	end,
})
