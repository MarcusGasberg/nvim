require("settings")
require("mappings")

require("plugins")
if not vim.g.vscode then
	require("lsp")
	require("colors")
else
	require("vscode")
end
require("autocommands")
