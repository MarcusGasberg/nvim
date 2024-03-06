local util = require("lspconfig").util

return {
	setup = function(capabilities, server)
		server.setup({
			capabilities = capabilities,
			on_attach = function()
				require("dap.ext.vscode").load_launchjs()
			end,
			root_dir = function(file, _)
				if file:sub(-#".csx") == ".csx" then
					return util.path.dirname(file)
				end
				return util.root_pattern("*.sln")(file) or util.root_pattern("*.csproj")(file)
			end,
		})
	end,
}
