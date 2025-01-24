local keymap = require("utils.keymap")
local fmt = require("utils.icons").fmt
keymap.normal_map("<leader>so", ":source $MYVIMRC<CR>", fmt("Restart", "Restart"))

-- Splits
keymap.normal_map("<leader>ss", ":split<Return><C-w>w", fmt("Window", "[Window] Hori[S]ontal [S]plit"))
keymap.normal_map("<leader>sv", ":vsplit<Return><C-w>w", fmt("Window", "[Window] [V]ertical [S]plit"))
keymap.normal_map("<leader>sh", "<C-w>h", fmt("Window", "[Window] left"))
keymap.normal_map("<leader>sj", "<C-w>j", fmt("Window", "[Window] down"))
keymap.normal_map("<leader>sk", "<C-w>k", fmt("Window", "[Window] up"))
keymap.normal_map("<leader>sl", "<C-w>l", fmt("Window", "[Window] right"))
keymap.normal_map("<leader>sq", "<C-w>q", fmt("Window", "[Window] [Q]uit"))
keymap.normal_map("<leader>sp", "<C-w><C-p>", fmt("Window", "[Window] [P]revious"))

-- no one is really happy until you have this shortcuts
local function cabbrev(input, replace)
  local cmd = string.format("cnoreabbrev %s %s", input, replace)
  vim.api.nvim_command(cmd)
end
vim.api.nvim_set_keymap("c", "W!", "w!", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "Q!", "q!", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "Qall!", "qall!", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "Wq", "wq", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "Wa", "wa", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "WA", "wa", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "wQ", "wq", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "WQ", "wq", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "Wqa", "wqa", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "WQA", "wqa", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "WQa", "wqa", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "Qa", "qa", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "Qa!", "qa!", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "Qall", "qall", { noremap = true, silent = true })

vim.api.nvim_set_keymap("c", "W", "w", { noremap = true, silent = true })
vim.api.nvim_set_keymap("c", "Q", "q", { noremap = true, silent = true })

-- move yank register to clipboard
keymap.normal_map("yc", function()
  vim.fn.setreg("+", vim.fn.getreg('"'))
end)

-- copy, cut and paste
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', {
  desc = fmt("Copy", "Yank to clipboard"),
})
vim.keymap.set({ "n", "v" }, "<leader>c", '"+c', {
  desc = fmt("Cut", "Cut to clipboard"),
})
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', {
  desc = fmt("Delete", "Delete to clipboard"),
})
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', {
  desc = fmt("Paste", "Paste from clipboard"),
})

-- Allows numbered jumps to be saved to the jumplist, for use w/ C-o and C-i
vim.api.nvim_exec2("nnoremap <expr> k (v:count > 1 ? \"m'\" . v:count : '') . 'k'", {})
vim.api.nvim_exec2("nnoremap <expr> j (v:count > 1 ? \"m'\" . v:count : '') . 'j'", {})

-- expand current directory when typing %% in command mode
vim.api.nvim_exec2("cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'", {})

vim.keymap.set("i", "<C-p>", "<nop>")
vim.keymap.set("i", "<C-n>", "<nop>")

return {}
