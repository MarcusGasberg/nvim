local keymap = require("utils.keymap")
local fmt = require("utils.icons").fmt
local trouble_ok, trouble = pcall(require, "trouble")

if not trouble_ok then
	print("Trouble is not installed. Please install it to use this configuration.")
	return
end

trouble.setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
})

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = fmt("Error", "[Trouble] " .. desc) })
end

map("<leader>xx", function()
	require("trouble").toggle()
end, "Toggle")
map("<leader>xw", function()
	require("trouble").toggle("workspace_diagnostics")
end, "Toggle Workspace Diagnostics")
map("<leader>xd", function()
	require("trouble").toggle("document_diagnostics")
end, "Toggle Document Diagnostics")
map("<leader>xq", function()
	require("trouble").toggle("quickfix")
end, "Toggle Quickfix")
map("<leader>xl", function()
	require("trouble").toggle("loclist")
end, "Toggle Loclist")
map("gR", function()
	require("trouble").toggle("lsp_references")
end, "Toggle LSP References")
