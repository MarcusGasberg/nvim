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
badd +148 lua/plugins/init.lua
badd +2 ~/AppData/Local/nvim/lua/plugins/ufo.lua
badd +162 lua/lsp/init.lua
badd +15 lua/plugins/null.lua
badd +18 lua/plugins/neoscroll.lua
badd +74 lua/mappings.lua
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
exe '1resize ' . ((&lines * 23 + 25) / 50)
exe '2resize ' . ((&lines * 23 + 25) / 50)
argglobal
balt lua/plugins/null.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("lua/lsp/init.lua", ":p")) | buffer lua/lsp/init.lua | else | edit lua/lsp/init.lua | endif
if &buftype ==# 'terminal'
  silent file lua/lsp/init.lua
endif
balt lua/plugins/null.lua
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=99
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
6,8fold
16,17fold
34,35fold
37,38fold
40,41fold
45,46fold
15,47fold
51,53fold
59,61fold
58,62fold
65,66fold
78,80fold
76,81fold
82,83fold
73,84fold
92,94fold
101,106fold
100,107fold
98,108fold
88,109fold
114,117fold
113,118fold
112,118fold
69,119fold
127,131fold
123,132fold
137,139fold
156,157fold
158,167fold
147,172fold
178,181fold
183,187fold
175,190fold
193,199fold
let &fdl = &fdl
let s:l = 2 - ((1 * winheight(0) + 11) / 23)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 03|
wincmd w
exe '1resize ' . ((&lines * 23 + 25) / 50)
exe '2resize ' . ((&lines * 23 + 25) / 50)
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
