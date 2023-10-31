vim.cmd([[nnoremap <leader>j <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>]])
vim.cmd([[nnoremap <leader>\ <Cmd>call VSCodeNotify('workbench.view.explorer')<CR>]])
vim.cmd([[nnoremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>]])
vim.cmd([[nnoremap gI <Cmd>call VSCodeNotify('editor.action.peekImplementation')<CR>]])
