local util = require("lspconfig").util
local pid = vim.fn.getpid()
local omnisharp_bin = "C:\\Users\\guest-maga\\AppData\\Local\\nvim-data\\lsp_servers\\omnisharp\\omnisharp\\OmniSharp.exe"

return {
	setup = function(on_attach, capabilities, server)
		server.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
			end,
			cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
			root_dir = function(file, _)
				if file:sub(-#".csx") == ".csx" then
					return util.path.dirname(file)
				end
				return util.root_pattern("*.sln")(file) or util.root_pattern("*.csproj")(file)
			end,
		})
	end,
}
