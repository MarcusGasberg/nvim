let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/AppData/Local/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +309 lua/plugins/telescope.lua
badd +2 lua/plugins/treesitter.lua
badd +6 lua/plugins/init.lua
badd +6 lua/settings.lua
badd +1 lua/plugins/leap.lua
badd +1 lua/plugins/gitsigns.lua
badd +2 lua/plugins/floaterm.lua
badd +23 lua/plugins/fugitive.lua
badd +1 lua/commands.lua
badd +12 lua/functions/utils.lua
badd +1 lua/plugins/neo-tree.lua
badd +1 lua/plugins/treesitter-context.lua
badd +90 lua/plugins/wilder.lua
badd +0 fugitive:///C:/Users/guest-maga/AppData/Local/nvim/.git//
argglobal
%argdel
edit fugitive:///C:/Users/guest-maga/AppData/Local/nvim/.git//
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 26 + 27) / 55)
exe '2resize ' . ((&lines * 25 + 27) / 55)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 13) / 26)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("lua/plugins/init.lua", ":p")) | buffer lua/plugins/init.lua | else | edit lua/plugins/init.lua | endif
if &buftype ==# 'terminal'
  silent file lua/plugins/init.lua
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 6 - ((5 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 6
normal! 031|
wincmd w
exe '1resize ' . ((&lines * 26 + 27) / 55)
exe '2resize ' . ((&lines * 25 + 27) / 55)
if exists(':tcd') == 2 | tcd ~/AppData/Local/nvim | endif
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
