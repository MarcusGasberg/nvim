local dap_ok, dap = pcall(require, "dap")
local mason_ok, mason_registry = pcall(require, "mason-registry")
if not dap_ok or not mason_ok then
	print("Could not find DAP or Mason")
	return
end

vim.keymap.set("n", "<silent> <F5>", "<Cmd>lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<silent> <F10>", "<Cmd>lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<silent> <F11>", "<Cmd>lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<silent> <F12>", "<Cmd>lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<silent> <Leader>B", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set(
	"n",
	"<silent> <Leader>BC",
	"<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
)
vim.keymap.set(
	"n",
	"<silent> <Leader>lp",
	"<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
)
vim.keymap.set("n", "<silent> <Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<silent> <Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>")

-- local netcoredbg = mason_registry.get_package("netcoredbg")
--
-- local netcoredbg_path = netcoredbg:get_install_path()
--
-- dap.adapters.coreclr = {
-- 	type = "executable",
-- 	command = netcoredbg_path .. "/netcoredbg/netcoredbg",
-- 	args = { "--interpreter=vscode" },
-- }
-- dap.configurations.cs = {
-- 	{
-- 		name = "launch - netcoredbg",
-- 		type = "coreclr",
-- 		request = "launch",
-- 		preLaunchTask = "build",
-- 		program = "${workspaceFolder}/Sirene3API/bin/Debug/net5.0/Sirene3API.dll",
-- 		args = {},
-- 		cwd = "${workspaceFolder}/Sirene3API",
-- 		stopAtEntry = false,
-- 		env = {
-- 			ASPNETCORE_ENVIRONMENT = "Development",
-- 		},
-- 	},
-- }

-- TODO Find out how to load the launch json from .vscode 
require('dap.ext.vscode').load_launchjs()
