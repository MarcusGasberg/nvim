vim.cmd([[nnoremap <leader><leader> <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>]])
vim.cmd([[nnoremap <leader>/ <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>]])

vim.cmd([[nnoremap <C-o> <Cmd>call VSCodeNotify('workbench.action.navigateBack')<CR>]])
vim.cmd([[nnoremap <C-i> <Cmd>call VSCodeNotify('workbench.action.navigateForward')<CR>]])


vim.cmd([[nnoremap <leader>x <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>]])
vim.cmd([[nnoremap \ <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>]])

vim.cmd([[nnoremap gd <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>]])
vim.cmd([[nnoremap gD <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>]])

vim.cmd([[nnoremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>]])
vim.cmd([[nnoremap gI <Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>]])
