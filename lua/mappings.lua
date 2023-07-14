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
cabbrev("W", "w")
cabbrev("Q", "q")
cabbrev("Qa", "qa")
cabbrev("Qa!", "qa!")
cabbrev("Qall", "qall")

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
vim.keymap.set("n", "n",  "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- move through buffers
vim.keymap.set("n", "<leader>[", ":bp!<CR>")
vim.keymap.set("n", "<leader>]", ":bn!<CR>")
vim.keymap.set("n", "<leader>x", ":bd<CR>")
vim.keymap.set("n", "<leader>X", ":BD<CR>")

-- copy, cut and paste
-- vim.keymap.set("v", "<C-c>", "\"+y")
-- vim.keymap.set("v", "<C-x>", "\"+c")
-- vim.keymap.set("n", "<C-v>", "c<ESC>\"+p")
-- vim.keymap.set("i", "<C-v>", "<ESC>\"+pa")

-- Delete a word backwards
vim.keymap.set('n', 'db', 'vb"_d')
vim.keymap.set('n', 'cb', 'vb"_c')

-- Delete/Change without writing to register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>c", "\"_c")
vim.keymap.set("v", "<leader>c", "\"_c")

-- Center on scroll. Doesn't work with smooth scrolling
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Allows numbered jumps to be saved to the jumplist, for use w/ C-o and C-i
vim.api.nvim_exec("nnoremap <expr> k (v:count > 1 ? \"m'\" . v:count : '') . 'k'", false)
vim.api.nvim_exec("nnoremap <expr> j (v:count > 1 ? \"m'\" . v:count : '') . 'j'", false)

-- expand current directory when typing %% in command mode
vim.api.nvim_exec("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'", false)

return {}
