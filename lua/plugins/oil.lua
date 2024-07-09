require("oil").setup({
	cleanup_delay_ms = 100,
	default_file_explorer = true,
	skip_confirm_for_simple_edits = true,
	view_options = {
		natural_order = true,
	},
})

vim.keymap.set("n", "\\", "<cmd>Oil<cr>", { desc = "Open parent directory" })
