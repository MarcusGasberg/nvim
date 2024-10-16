vim.print("GOT HERE")
vim.g.rustaceanvim = {
	-- Plugin configuration
	tools = {
	},
	-- LSP configuration
	server = {
		on_attach = function(client, bufnr)
			-- you can also put keymaps in here
		end,
		default_settings = {
			-- rust-analyzer language server configuration
			['rust-analyzer'] = {
				rustfmt = {
					overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
				},
				procMacro = {
					ignored = {
						leptos_macro = {
							"component",
							"server",
						},
					},
				},
			},
		},
	},
	-- DAP configuration
	dap = {
	},
}
