vim.keymap.set("n","<Leader>sv", ":source $MYVIMRC<CR>")

-- Splits
-- vim.keymap.set("n", "ss", ":split<Return><C-w>w")
-- vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w")
-- vim.keymap.set("n", "sh", "<C-w>h")
-- vim.keymap.set("n", "sj", "<C-w>j")
-- vim.keymap.set("n", "sk", "<C-w>k")
-- vim.keymap.set("n", "sl", "<C-w>l")
-- vim.keymap.set("n", "sq", "<C-w>q")
-- vim.keymap.set("n", "sp", "<C-w><C-p>")

-- no one is really happy until you have this shortcuts
local function cabbrev(input, replace)
  local cmd = 'cnoreabbrev %s %s'

  vim.cmd(cmd:format(input, replace))
end
cabbrev("W!", "w!")
cabbrev("Q!", "q!")
cabbrev("Qall!", "qall!")
cabbrev("Wq", "wq")
cabbrev("Wa", "wa")
cabbrev("wQ", "wq")
cabbrev("WQ", "wq")
cabbrev("Wqa", "wqa")
cabbrev("WQA", "wqa")
cabbrev("WQa", "wqa")
cabbrev("W", "w")
cabbrev("Q", "q")
cabbrev("Qa", "qa")
cabbrev("Qa!", "qa!")
cabbrev("Qall", "qall")

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
vim.keymap.set({"n", "v"}, "n",  "nzzzv")
vim.keymap.set({"n", "v"}, "N", "Nzzzv")

-- move through buffers
vim.keymap.set("n", "<leader>[", ":bp!<CR>")
vim.keymap.set("n", "<leader>]", ":bn!<CR>")
vim.keymap.set("n", "<leader>x", ":bd<CR>")
vim.keymap.set("n", "<leader>X", ":BD<CR>")

-- copy, cut and paste
vim.keymap.set({ "n", "v"}, "<leader>y", "\"+y")
vim.keymap.set({"n", "v"}, "<leader>c", "\"+c")
vim.keymap.set({"n", "v"}, "<leader>d", "\"+d")
vim.keymap.set({"n","v"}, "<leader>p", "\"+p")

-- Center on scroll. Doesn't work with smooth scrolling
vim.keymap.set({"n", "v"}, "<C-d>", "<C-d>zz")
vim.keymap.set({"n", "v"}, "<C-u>", "<C-u>zz")

vim.keymap.set({"n", "v"}, "G", "Gzz")

-- Allows numbered jumps to be saved to the jumplist, for use w/ C-o and C-i
vim.api.nvim_exec2("nnoremap <expr> k (v:count > 1 ? \"m'\" . v:count : '') . 'k'", {})
vim.api.nvim_exec2("nnoremap <expr> j (v:count > 1 ? \"m'\" . v:count : '') . 'j'", {})

-- expand current directory when typing %% in command mode
vim.api.nvim_exec2("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'", {})

return {}
