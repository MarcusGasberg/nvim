vim.g.vimspector_install_gadgets = { 'debugpy', 'vscode-cpptools', 'CodeLLDB', 'delve', 'netcoredbg' }

vim.keymap.set("n", "<Leader>dd", ":call vimspector#Launch()<CR>")
vim.keymap.set("n", "<Leader>de", ":call vimspector#Reset()<CR>")
vim.keymap.set("n", "<Leader>dc", ":call vimspector#Continue()<CR>")
vim.keymap.set("n", "nnoremap", "<Leader>dt :call vimspector#ToggleBreakpoint()<CR>")
vim.keymap.set("n", "<Leader>dT", ":call vimspector#ClearBreakpoints()<CR>")

vim.keymap.set("n", "<Leader>dh", "<Plug>VimspectorStepOut")
vim.keymap.set("n", "<Leader>dk", "<Plug>VimspectorStepInto")
vim.keymap.set("n", "<Leader>dj", "<Plug>VimspectorStepOver")
vim.keymap.set("n", "<Leader>dl", "<Plug>VimspectorRestart")
