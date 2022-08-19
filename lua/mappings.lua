
vim.keymap.set("n","<Leader>sv", ":source $MYVIMRC<CR>")

-- Splits
vim.keymap.set("n", "ss", ":split<Return><C-w>w")

vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w")
vim.keymap.set("n", "sh", "<C-w>h")
vim.keymap.set("n", "sj", "<C-w>j")
vim.keymap.set("n", "sk", "<C-w>k")
vim.keymap.set("n", "sl", "<C-w>l")
vim.keymap.set("n", "sq", "<C-w>q")
vim.keymap.set("n", "sp", "<C-w><C-p>")

vim.keymap.set("n", "<leader><Up>", ":wincmd k<CR>")
vim.keymap.set("n", "<leader><Down>", ":wincmd j<CR>")
vim.keymap.set("n", "<leader><Left>", ":wincmd h<CR>")
vim.keymap.set("n", "<leader><Right>", ":wincmd l<CR>")

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
cabbrev("W", "w")
cabbrev("Q", "q")
cabbrev("Qall", "qall")

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
vim.keymap.set("n", "n",  "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set("n", "gx", "!start <c-r><c-a>")

-- move through buffers
vim.keymap.set("n", "<leader>[", ":bp!<CR>")
vim.keymap.set("n", "<leader>]", ":bn!<CR>")
vim.keymap.set("n", "<leader>x", ":bd<CR>")
vim.keymap.set("n", "<leader>X", ":BD<CR>")

-- copy, cut and paste
vim.keymap.set("v", "<C-c>", "\"+y")
vim.keymap.set("v", "<C-x>", "\"+c")
vim.keymap.set("n", "<C-v>", "c<ESC>\"+p")
vim.keymap.set("i", "<C-v>", "<ESC>\"+pa")

-- search
vim.keymap.set("n", "<C-n>", ":nohl<CR>")

-- Allows numbered jumps to be saved to the jumplist, for use w/ C-o and C-i
vim.api.nvim_exec("nnoremap <expr> k (v:count > 1 ? \"m'\" . v:count : '') . 'k'", false)
vim.api.nvim_exec("nnoremap <expr> j (v:count > 1 ? \"m'\" . v:count : '') . 'j'", false)

return {}
