return {
	setup = function(capabilities, server)
		server.setup({
			filetypes = { "angular", "html", "typescript", "typescriptreact" },
			root_dir = require("lspconfig").util.root_pattern("angular.json", "project.json"),
			capabilities = capabilities,
		})
	end,
}
