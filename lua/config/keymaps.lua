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
	local cmd = "cnoreabbrev %s %s"

	vim.cmd(cmd:format(input, replace))
end
cabbrev("W!", "w!")
cabbrev("Q!", "q!")
cabbrev("Qall!", "qall!")
cabbrev("Wq", "wq")
cabbrev("Wa", "wa")
cabbrev("WA", "wa")
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

-- move through buffers
keymap.normal_map("<leader>[", ":bp!<CR>", fmt("Stack", "Previous buffer"))
keymap.normal_map("<leader>]", ":bn!<CR>", fmt("Stack", "Next buffer"))

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
