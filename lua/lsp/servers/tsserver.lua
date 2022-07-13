local tsserver_on_attach = function(client, bufnr)
  local clients = vim.lsp.get_active_clients()

  for _, value in ipairs(clients) do
    print(value.name)
    if value.name == 'angularls' then
      client.server_capabilities.renameProvider  = false
    end
  end
end

return {
	setup = function(on_attach, capabilities, server)
		server:setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end,
}
