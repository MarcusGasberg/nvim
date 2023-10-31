-- Highlight after yank
vim.cmd([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
  augroup END
]])

vim.cmd([[
  autocmd FileType markdown,text set wrap linebreak nolist textwidth=80 formatoptions=cqt wrapmargin=0
]])

vim.cmd([[
" Position the (global) quickfix window at the very bottom of the window https://github.com/fatih/vim-go/issues/1757
  autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif
]])

-- vim.cmd([[
-- " trigger `autoread` when files changes on disk
--   set autoread
--   autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! if mode() != 'c' | checktime | endif
-- " notification after file change
--   autocmd FileChangedShellPost *
--   \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
-- ]])

-- enable syntax highlighting for csharp files
vim.cmd([[
augroup Html
    au!
    au BufNewFile,BufRead *.aspx setl filetype=html
    au BufNewFile,BufRead *.cshtml set filetype=html
    au BufNewFile,BufRead *.ascx set filetype=html
augroup END
]])

vim.cmd([[
augroup KeepCentered
  autocmd!
  autocmd CursorMoved,CursorMovedI * call CentreCursor()
augroup END
function! CentreCursor()
    let pos = getpos(".")
    normal! zz
    call setpos(".", pos)
endfunction
]])

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
