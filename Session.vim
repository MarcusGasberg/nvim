let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +123 lua/functions/utils.lua
badd +38 lua/lsp/init.lua
badd +2 lua/plugins/telescope.lua
badd +4 init.lua
badd +1 lua/plugins/autopairs.lua
badd +44 lua/plugins/startup.lua
badd +5 lua/plugins/scrollbar.lua
badd +159 lua/plugins/init.lua
badd +8 lua/plugins/luasnip.lua
badd +12 lua/plugins/null.lua
badd +2 lua/lsp/cmp.lua
badd +81 lua/plugins/treesitter.lua
badd +42 lua/plugins/wilder.lua
badd +1 lua/plugins/treesitter-context.lua
badd +1 lua/plugins/lualine.lua
badd +2 lua/plugins/gitsigns.lua
argglobal
%argdel
edit lua/plugins/init.lua
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt lua/plugins/gitsigns.lua
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
81,84fold
78,86fold
88,91fold
101,104fold
106,110fold
119,122fold
124,127fold
131,134fold
137,140fold
143,145fold
153,156fold
38,159fold
let &fdl = &fdl
let s:l = 159 - ((58 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 159
normal! 035|
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
