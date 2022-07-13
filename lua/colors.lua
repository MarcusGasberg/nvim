vim.cmd("set termguicolors")
vim.cmd([[ :set signcolumn=yes ]])
vim.cmd([[ :hi NonText guifg=bg ]])

local gruvbox_ok = pcall(require, "gruvbox")
if not gruvbox_ok then
	print("gruvbox is not installed.")
	return
end

vim.api.nvim_exec([[
colorscheme gruvbox
set background=dark
]], true)
