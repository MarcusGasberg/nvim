require("neotest").setup({
	icons = {
		expanded = "",
		child_prefix = "",
		child_indent = "",
		final_child_prefix = "",
		non_collapsible = "",
		collapsed = "",

		passed = "",
		running = "",
		failed = "",
		unknown = "",
		running_animated = { "◴", "◷", "◶", "◵" },
	},

	adapters = {
		require("neotest-jest")({
			jestCommand = "jest",
			jestConfigFile = function()
				local file = vim.fn.expand("%:p")
				if string.find(file, "/libs|apps/") then
					return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
				end

				return vim.fn.getcwd() .. "/jest.config.ts"
			end,
			env = { CI = true },
			cwd = function(path)
				return vim.fn.getcwd()
			end,
		}),
		require("neotest-vim-test")({ ignore_filetypes = { "typescript" } }),
	},
})

vim.keymap.set("n", "<leader>tt", "<cmd>w<CR><cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
vim.keymap.set("n", "<leader>ta", "<cmd>w<CR><cmd>lua require('neotest').run.run({ suite = true })<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>w<CR><cmd>lua require('neotest').run.run()<CR>")
vim.keymap.set("n", "<leader>tl", "<cmd>w<CR><cmd>lua require('neotest').run.run_last()<CR>")
vim.keymap.set("n", "<leader>to", "<cmd>w<CR><cmd>lua require('neotest').output.open()<CR>")
vim.keymap.set("n", "<leader>tp", "<cmd>w<CR><cmd>lua require('neotest').output_panel.toggle()<CR>")
vim.keymap.set("n", "<leader>ts", "<cmd>w<CR><cmd>lua require('neotest').summary.toggle()<CR>")
vim.keymap.set("n", "<leader>td", function()
	vim.cmd("w")
	require("neotest").run.run({ strategy = "dap" })
end)
