require("config.options")
require("config.autocommands")
require("config.keymaps")
require("config.lazy")

if vim.g.vscode then
  require("vscode-mappings")
end
