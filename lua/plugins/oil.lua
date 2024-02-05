require("oil").setup({
  cleanup_delay_ms = 100,
})

vim.keymap.set("n", "\\", "<cmd>Oil<cr>", { desc = "Open parent directory"})
