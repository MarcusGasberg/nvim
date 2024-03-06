local tsserver_on_attach = function(client, bufnr)
	local angular_client = vim.lsp.get_clients({
		bufnr = bufnr,
		name = "angularls",
	})

	if angular_client then
		client.server_capabilities.renameProvider = false
		client.server_capabilities.rename = false
	end
end

return {
	setup = function(capabilities, server)
		-- server.setup({
		-- 	capabilities = capabilities,
		-- 	root_dir = require("lspconfig").util.root_pattern("package.json"),
		-- 	on_attach = function(client, bufnr)
		-- 		tsserver_on_attach(client, bufnr)
		-- 	end,
		-- })
	end,
}
