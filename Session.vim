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
badd +376 lua/plugins/telescope.lua
badd +8 lua/lsp/cmp.lua
badd +16 lua/lsp/servers/tsserver.lua
badd +2 lua/plugins/fugitive.lua
badd +2 lua/functions/init.lua
badd +215 health://
badd +126 lua/lsp/init.lua
badd +7 lua/plugins/null.lua
badd +149 lua/plugins/init.lua
badd +75 lua/settings.lua
badd +5 lua/plugins/lazygit.lua
badd +2 lua/plugins/toggleterm.lua
badd +2 lua/plugins/ufo.lua
badd +5 lua/plugins/treesitter.lua
argglobal
%argdel
edit lua/plugins/init.lua
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
4,6fold
9,11fold
14,15fold
12,16fold
7,17fold
3,18fold
2,19fold
25,31fold
24,32fold
41,42fold
39,43fold
50,56fold
46,57fold
65,67fold
62,69fold
88,91fold
93,95fold
101,104fold
106,110fold
119,122fold
124,127fold
131,134fold
137,140fold
143,145fold
157,160fold
153,161fold
163,166fold
38,167fold
let &fdl = &fdl
let s:l = 149 - ((27 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 149
normal! 059|
if exists(':tcd') == 2 | tcd ~/AppData/Local/nvim | endif
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
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
