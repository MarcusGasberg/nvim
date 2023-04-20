local toggle_status = function()
	local ft = vim.bo.filetype
	if ft == "fugitive" then
		vim.api.nvim_command("bd")
	else
		vim.api.nvim_command("Git")
	end
end

vim.keymap.set("n", "<leader>gs", toggle_status, {})
vim.keymap.set("n", "<Leader>ga", ":Gwrite<CR>")
vim.keymap.set("n", "<Leader>gc", ":Git commit --verbose<CR>")
vim.keymap.set("n", "<Leader>gf", ":Git! fetch<CR>")
vim.keymap.set("n", "<Leader>gph", ":Git! push<CR>")
vim.keymap.set("n", "<Leader>gll", ":Git! pull<CR>")
vim.keymap.set("n", "<Leader>glb", ":Git blame<CR>")
vim.keymap.set("n", "<Leader>gb", ":Git branch<CR>")
vim.keymap.set("n", "<Leader>gd", ":Gvdiffsplit!<CR>")
vim.keymap.set("n", "<Leader>gdh", ":diffget //2<CR>")
vim.keymap.set("n", "<Leader>gdl", ":diffget //3<CR>")
vim.keymap.set("n", "<Leader>gr", ":GRemove<CR>")
