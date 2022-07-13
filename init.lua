-- if vim.loop.os_uname().sysname == "Windows_NT" then
--   $PATH = "C:/Program Files\\Git\\usr\\bin;" . $PATH
-- end
-- Basic Settings
require("settings")

-- Language Server
require("lsp")

-- Other Mappings and Settings
require("colors")
require("mappings")
-- require("functions")
-- require("autocommands")
-- require("commands")

-- Packer plugins
require("plugins")

