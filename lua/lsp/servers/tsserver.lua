local tsserver_on_attach = function(client, bufnr)
  local clients = vim.lsp.get_active_clients()

  for _, value in ipairs(clients) do
    if value.name == "angularls" then
      client.server_capabilities.renameProvider = false
      client.server_capabilities.rename = false
    end
  end
end

return {
  setup = function(on_attach, capabilities, server)
    -- handled by tsserver plugin
    -- server.setup({
    --   capabilities = capabilities,
    --   root_dir = require("lspconfig").util.root_pattern("package.json"),
    --   on_attach = function(client, bufnr)
	   --    tsserver_on_attach(client, bufnr)
	   --    on_attach(client, bufnr)
    --   end,
    -- })
  end,
}
