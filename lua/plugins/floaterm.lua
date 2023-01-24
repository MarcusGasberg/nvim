vim.keymap.set("n", "<C-t>", ":FloatermNew<CR>")
vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:FloatermNew<CR>")
vim.keymap.set("n", "<C-p>", "<cmd>:FloatermPrev<CR>")
vim.keymap.set("t", "<C-p>", "<C-\\><C-n><cmd>:FloatermPrev<CR>")
vim.keymap.set("n", "<C-n>", "<cmd>:FloatermNext<CR>")
vim.keymap.set("t", "<C-n>", "<C-\\><C-n><cmd>:FloatermNext<CR>")
vim.keymap.set("n", "<C-z>", "<cmd>:FloatermToggle<CR>")
vim.keymap.set("t", "<C-z>", "<C-\\><C-n><cmd>:FloatermToggle<CR>")
vim.g.floaterm_width = 0.95
vim.g.floaterm_height = 0.95
vim.keymap.set('n', '<leader>gs', '<cmd>:FloatermNew lazygit<CR>')
