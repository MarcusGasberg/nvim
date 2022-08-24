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
vim.keymap.set("n", "<silent> <Leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<silent> <Leader>B", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<silent> <Leader>lp", "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<silent> <Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<silent> <Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>")

local netcoredbg = mason_registry.get_package("netcoredbg")

local netcoredbg_path = netcoredbg:get_install_path()

dap.adapters.coreclr = {
  type = 'executable',
  command =  netcoredbg_path ..'/netcoredbg/netcoredbg',
  args = {'--interpreter=vscode'}
}
-- dap.configurations.cs = {
--   {
--     type = "coreclr",
--     name = "launch - netcoredbg",
--     request = "launch",
--     program = function()
--         return vim.fn.input('Path to dll: ', vim.fn.getcwd(), 'file')
--     end,
--   },
-- }
dap.configurations.cs = require('dap.ext.vscode').load_launchjs()
