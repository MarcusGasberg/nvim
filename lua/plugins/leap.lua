local leap_ok, leap = pcall(require,"leap")

if not leap_ok then
	print("Leap is not installed")
	return
end

leap.add_default_mappings()
vim.cmd([[ 
	autocmd ColorScheme * lua require('leap').init_highlight(true)
]])
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
