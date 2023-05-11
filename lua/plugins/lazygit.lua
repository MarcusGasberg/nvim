local keymap = vim.keymap.set
local silent = { silent = true }

print("GOT HERE")
keymap("n", "<leader>gs", "<cmd>LazyGit<CR>", silent)
