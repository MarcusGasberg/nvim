let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +144 nvim/lua/lsp/init.lua
badd +187 nvim/lua/plugins/init.lua
badd +1 nvim/lua/utils/icons.lua
badd +44 nvim/lua/plugins/telescope.lua
badd +25 nvim/lua/plugins/neotest.lua
badd +3 nvim/lua/utils/keymap.lua
badd +57 nvim/lua/plugins/gitsigns.lua
badd +3 nvim/lua/mappings.lua
badd +31 nvim/lua/plugins/trouble.lua
badd +60 nvim/lua/plugins/dap-ui.lua
badd +152 nvim/lua/plugins/snippets/my-snippets/angular.json
badd +734 nvim/lua/plugins/snippets/my-snippets/typescript.json
badd +174 nvim/lua/functions/utils.lua
badd +1 nvim/lua/plugins/treesitter.lua
badd +32 ~/source/repos/command-center/feature/LY-796-fdd0035-customer-account/apps/dashboard/src/app/organization/add-organization-node-dialog/add-organization-node-dialog.component.html
badd +124 nvim/lua/plugins/nvim-dap.lua
badd +1 nvim/lua/lsp/servers/tailwindcss.lua
badd +2 nvim/lua/lsp/servers/sumneko_lua.lua
badd +1 nvim/lua/lsp/servers/emmet_language_server.lua
badd +9 nvim/lua/lsp/servers/angularls.lua
badd +70 nvim/lua/lsp/cmp.lua
badd +8 nvim/lua/plugins/color-schemes/rose-pine.lua
badd +5 nvim/lua/plugins/oil.lua
badd +1 nvim/lua/plugins/sql.lua
badd +5 nvim/lua/plugins/lint.lua
badd +6 nvim/lua/autocommands.lua
badd +14 nvim/lua/plugins/conform.lua
badd +19 nvim/lua/plugins/copilot.lua
badd +1 nvim/lua/lsp/servers/omnisharp.lua
badd +52 nvim/lua/plugins/typescript-tools.lua
badd +1 nvim/lua/plugins/noice.lua
badd +37 nvim/lua/plugins/mini.lua
badd +1 health://
badd +1 nvim/lua/lsp/servers/ts_ls.lua
badd +1 nvim/lua/vscode-mappings.lua
badd +9 nvim/init.lua
badd +1 nvim/ftplugin/rust.lua
badd +1 nvim/ftplugin/cs.lua
badd +51 nvim/lua/plugins/color-schemes/catpuccin.lua
badd +1 nvim/lua/plugins/modes.lua
badd +3 nvim/lua/colors.lua
badd +2 nvim/lua/plugins/color-schemes/zenbones.lua
badd +78 nvim/lua/settings.lua
badd +23 nvim/lua/plugins/toggleterm.lua
badd +13 nvim/lua/plugins/lualine.lua
badd +72 tmux/tmux.conf
badd +1 /tmp/nvim.maga/3jBOye/prov-events-devicestatechange-List-2024-10-15-08-19-44
badd +1 /tmp/nvim.maga/3jBOye/prov-events-connectionchange-List-2024-10-15-08-19-57
badd +14 ~/.config/nvim/lua/plugins/rust.lua
badd +1 /tmp/nvim.maga/227keC/postgres-tasks-task-List-2024-10-16-06-45-10
badd +1 /tmp/nvim.maga/227keC/postgres-device-pump-List-2024-10-16-10-31-37
badd +1 /tmp/nvim.maga/227keC/postgres-tasks-task-List-2024-10-16-10-36-27
badd +1 /tmp/nvim.maga/227keC/postgres-device-pump-List-2024-10-16-10-37-27
badd +1 /tmp/nvim.maga/227keC/postgres-device-device-List-2024-10-16-10-37-50
badd +1 /tmp/nvim.maga/227keC/postgres-device-pump-List-2024-10-16-10-39-15
argglobal
%argdel
edit /tmp/nvim.maga/227keC/postgres-device-pump-List-2024-10-16-10-39-15
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
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
exe 'vert 1resize ' . ((&columns * 40 + 118) / 236)
exe 'vert 2resize ' . ((&columns * 116 + 118) / 236)
exe 'vert 3resize ' . ((&columns * 78 + 118) / 236)
argglobal
enew
file dbui
balt ~/.config/nvim/lua/plugins/rust.lua
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> <nowait> <silent> <NL> <Plug>(DBUI_GotoLastSibling)
nmap <buffer> <nowait> <silent>  <Plug>(DBUI_GotoFirstSibling)
nmap <buffer> <nowait> <silent>  <Plug>(DBUI_SelectLine)
nmap <buffer> <nowait> <silent>  <Plug>(DBUI_GotoChildNode)
nmap <buffer> <nowait> <silent>  <Plug>(DBUI_GotoParentNode)
nmap <buffer> <nowait> <silent> A <Plug>(DBUI_AddConnection)
nmap <buffer> <nowait> <silent> H <Plug>(DBUI_ToggleDetails)
nmap <buffer> <nowait> <silent> J <Plug>(DBUI_GotoNextSibling)
nmap <buffer> <nowait> <silent> K <Plug>(DBUI_GotoPrevSibling)
nmap <buffer> <nowait> <silent> R <Plug>(DBUI_Redraw)
nmap <buffer> <nowait> <silent> S <Plug>(DBUI_SelectLineVsplit)
nmap <buffer> <nowait> <silent> d <Plug>(DBUI_DeleteLine)
nmap <buffer> <nowait> <silent> o <Plug>(DBUI_SelectLine)
nmap <buffer> <nowait> <silent> q <Plug>(DBUI_Quit)
nmap <buffer> <nowait> <silent> r <Plug>(DBUI_RenameLine)
nmap <buffer> <nowait> <silent> <C-N> <Plug>(DBUI_GotoChildNode)
nmap <buffer> <nowait> <silent> <C-P> <Plug>(DBUI_GotoParentNode)
nmap <buffer> <nowait> <silent> <C-J> <Plug>(DBUI_GotoLastSibling)
nmap <buffer> <nowait> <silent> <C-K> <Plug>(DBUI_GotoFirstSibling)
nmap <buffer> <nowait> <silent> <2-LeftMouse> <Plug>(DBUI_SelectLine)
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=wipe
setlocal nobuflisted
setlocal buftype=nofile
setlocal cindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-,fb:â€¢
setlocal commentstring=
setlocal complete=.,w,b,u,t
setlocal completefunc=
setlocal completeopt=
setlocal concealcursor=
setlocal conceallevel=0
setlocal nocopyindent
setlocal nocursorbind
setlocal nocursorcolumn
setlocal cursorline
setlocal cursorlineopt=both
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'dbui'
setlocal filetype=dbui
endif
setlocal fillchars=
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatoptions=cqt
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,0=end,0=until
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispoptions=
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal nomodifiable
setlocal nrformats=bin,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal scrollback=-1
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=no
setlocal smartindent
setlocal nosmoothscroll
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\\t\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=
setlocal statuscolumn=
setlocal statusline=%#lualine_transitional_lualine_a_normal_to_StatusLine#î‚¶%#lualine_a_normal#\ NORMAL\ %#lualine_b_normal#\ dbui\ [-]\ %#lualine_transitional_lualine_b_normal_to_lualine_c_normal#î‚´%<%#lualine_c_normal#%=%#lualine_transitional_lualine_y_filetype_DevIconDefault_normal_to_lualine_c_normal#î‚¶%#lualine_y_filetype_DevIconDefault_normal#\ î˜’\ %#lualine_b_normal#dbui\ %#lualine_b_normal#|%#lualine_b_normal#\ 83%%\ %#lualine_a_normal#\ \ 66:1\ \ %#lualine_transitional_lualine_a_normal_to_StatusLine#î‚´
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'dbui'
setlocal syntax=dbui
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal textwidth=80
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal winbar=
setlocal winblend=0
setlocal nowinfixbuf
setlocal nowinfixheight
setlocal winfixwidth
setlocal winhighlight=CursorLineNr:CursorLineNr,CursorLineFold:CursorLineFold,CursorLine:CursorLine,Visual:Visual,CursorLineSign:CursorLineSign
setlocal nowrap
setlocal wrapmargin=0
wincmd w
argglobal
balt /tmp/nvim.maga/227keC/postgres-device-device-List-2024-10-16-10-37-50
let s:cpo_save=&cpo
set cpo&vim
inoremap <buffer> <C-C>R :call sqlcomplete#Map("resetCache")
inoremap <buffer> <Left> =sqlcomplete#DrillOutOfColumns()
inoremap <buffer> <Right> =sqlcomplete#DrillIntoTable()
inoremap <buffer> <C-C>L :call sqlcomplete#Map("column_csv")
inoremap <buffer> <C-C>l :call sqlcomplete#Map("column_csv")
inoremap <buffer> <C-C>c :call sqlcomplete#Map("column")
inoremap <buffer> <C-C>v :call sqlcomplete#Map("view")
inoremap <buffer> <C-C>p :call sqlcomplete#Map("procedure")
inoremap <buffer> <C-C>t :call sqlcomplete#Map("table")
inoremap <buffer> <C-C>s :call sqlcomplete#Map("sqlStatement\\w*")
inoremap <buffer> <C-C>T :call sqlcomplete#Map("sqlType\\w*")
inoremap <buffer> <C-C>o :call sqlcomplete#Map("sqlOption\\w*")
inoremap <buffer> <C-C>f :call sqlcomplete#Map("sqlFunction\\w*")
inoremap <buffer> <C-C>k :call sqlcomplete#Map("sqlKeyword\\w*")
inoremap <buffer> <C-C>a :call sqlcomplete#Map("syntax")
vnoremap <buffer>  a <Cmd>lua require('fastaction').range_code_action()
nnoremap <buffer>  a <Cmd>lua require("fastaction").code_action()
vmap <buffer> <nowait> <silent>  S <Plug>(DBUI_ExecuteQuery)
nmap <buffer> <nowait> <silent>  S <Plug>(DBUI_ExecuteQuery)
nmap <buffer> <nowait> <silent>  E <Plug>(DBUI_EditBindParameters)
nmap <buffer> <nowait> <silent>  W <Plug>(DBUI_SaveQuery)
xnoremap <buffer> <silent> [" :exec "normal! gv"|call search('\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)\@!', "W" )
nnoremap <buffer> <silent> [" :call search('\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\(^\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)\@!', "W" )
xnoremap <buffer> <silent> [{ ?\c^\s*\(\(create\)\s\+\(or\s\+replace\s\+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>
nnoremap <buffer> <silent> [{ :call search('\c^\s*\(\(create\)\s\+\(or\s\+replace\s\+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>', 'bW')
xnoremap <buffer> <silent> ]" :exec "normal! gv"|call search('^\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\@<!\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)', "W" )
nnoremap <buffer> <silent> ]" :call search('^\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\).*\n\)\@<!\(\s*\(--\|\/\/\|\*\|\/\*\|\*\/\)\)', "W" )
xnoremap <buffer> <silent> ]} /\c^\s*\(\(create\)\s\+\(or\s\+replace\s\+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>
nnoremap <buffer> <silent> ]} :call search('\c^\s*\(\(create\)\s\+\(or\s\+replace\s\+\)\{,1}\)\{,1}\<\(function\|procedure\|event\|\(existing\|global\s\+temporary\s\+\)\{,1}table\|trigger\|schema\|service\|publication\|database\|datatype\|domain\|index\|subscription\|synchronization\|view\|variable\)\>', 'W')
inoremap <buffer> R :call sqlcomplete#Map("resetCache")
inoremap <buffer> L :call sqlcomplete#Map("column_csv")
inoremap <buffer> l :call sqlcomplete#Map("column_csv")
inoremap <buffer> c :call sqlcomplete#Map("column")
inoremap <buffer> v :call sqlcomplete#Map("view")
inoremap <buffer> p :call sqlcomplete#Map("procedure")
inoremap <buffer> t :call sqlcomplete#Map("table")
inoremap <buffer> s :call sqlcomplete#Map("sqlStatement\\w*")
inoremap <buffer> T :call sqlcomplete#Map("sqlType\\w*")
inoremap <buffer> o :call sqlcomplete#Map("sqlOption\\w*")
inoremap <buffer> f :call sqlcomplete#Map("sqlFunction\\w*")
inoremap <buffer> k :call sqlcomplete#Map("sqlKeyword\\w*")
inoremap <buffer> a :call sqlcomplete#Map("syntax")
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=s1:/*,mb:*,ex:*/,:--,://
setlocal commentstring=--\ %s
setlocal complete=.,w,b,u,t
setlocal completefunc=
setlocal completeopt=
setlocal concealcursor=
setlocal conceallevel=0
setlocal nocopyindent
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=\\c\\<\\(VARIABLE\\|DECLARE\\|IN\\|OUT\\|INOUT\\)\\>
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'sql'
setlocal filetype=sql
endif
setlocal fillchars=
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatoptions=qc
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=
setlocal indentexpr=nvim_treesitter#indent()
setlocal indentkeys=0),0],!^F,o,O,0=end,0=until,=~end,=~else,=~elseif,=~elsif,0=~when,0=)
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispoptions=
setlocal lispwords=
setlocal nolist
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,hex
setlocal number
setlocal numberwidth=4
setlocal omnifunc=sqlcomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal scrollback=-1
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=2
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=yes
setlocal smartindent
setlocal nosmoothscroll
setlocal softtabstop=0
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\\t\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=noplainbuffer
setlocal statuscolumn=
setlocal statusline=%#lualine_a_inactive#\ postgres-device-pump-List-2024-10-16-10-39-15\ %<%#lualine_c_inactive#%=%#lualine_a_inactive#\ \ \ 1:1\ \ 
setlocal suffixesadd=
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != ''
setlocal syntax=
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=
setlocal tags=
setlocal textwidth=80
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal winbar=
setlocal winblend=0
setlocal nowinfixbuf
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal winhighlight=CursorLineNr:CursorLineNr,CursorLineFold:CursorLineFold,CursorLine:CursorLine,Visual:Visual,CursorLineSign:CursorLineSign
setlocal nowrap
setlocal wrapmargin=0
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("nvim/lua/lsp/init.lua", ":p")) | buffer nvim/lua/lsp/init.lua | else | edit nvim/lua/lsp/init.lua | endif
if &buftype ==# 'terminal'
  silent file nvim/lua/lsp/init.lua
endif
balt ~/.config/nvim/lua/plugins/rust.lua
let s:cpo_save=&cpo
set cpo&vim
vnoremap <buffer>  a <Cmd>lua require('fastaction').range_code_action()
nnoremap <buffer>  a <Cmd>lua require("fastaction").code_action()
xnoremap <buffer> <silent> af <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@function.outer','textobjects','x')
onoremap <buffer> <silent> af <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@function.outer','textobjects','o')
xnoremap <buffer> <silent> if <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@function.inner','textobjects','x')
onoremap <buffer> <silent> if <Cmd>lua require'nvim-treesitter.textobjects.select'.select_textobject('@function.inner','textobjects','o')
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal backupcopy=
setlocal nobinary
setlocal nobreakindent
setlocal breakindentopt=
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinscopedecls=public,protected,private
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:---,:--
setlocal commentstring=--\ %s
setlocal complete=.,w,b,u,t
setlocal completefunc=
setlocal completeopt=
setlocal concealcursor=
setlocal conceallevel=0
setlocal nocopyindent
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal cursorlineopt=both
setlocal define=\\<function\\|\\<local\\%(\\s\\+function\\)\\=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal noexpandtab
if &filetype != 'lua'
setlocal filetype=lua
endif
setlocal fillchars=
setlocal fixendofline
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=v:lua.vim.lsp.formatexpr()
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal formatoptions=jcroql
setlocal formatprg=
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=-1
setlocal include=
setlocal includeexpr=tr(v:fname,'.','/')
setlocal indentexpr=nvim_treesitter#indent()
setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e,0=end,0=until
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
setlocal lispoptions=
setlocal lispwords=
setlocal list
setlocal listchars=
setlocal makeencoding=
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=bin,hex
setlocal number
setlocal numberwidth=4
setlocal omnifunc=v:lua.vim.lsp.omnifunc
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal relativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal scrollback=-1
setlocal noscrollbind
setlocal scrolloff=-1
setlocal shiftwidth=0
setlocal showbreak=
setlocal sidescrolloff=-1
setlocal signcolumn=yes
setlocal smartindent
setlocal nosmoothscroll
setlocal softtabstop=-1
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\\t\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal spelloptions=noplainbuffer
setlocal statuscolumn=
setlocal statusline=%#lualine_a_inactive#\ init.lua\ %<%#lualine_c_inactive#%=%#lualine_a_inactive#\ 144:1\ \ 
setlocal suffixesadd=.lua
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != ''
setlocal syntax=
endif
setlocal tabstop=2
setlocal tagcase=
setlocal tagfunc=v:lua.vim.lsp.tagfunc
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal thesaurusfunc=
setlocal undofile
setlocal undolevels=-123456
setlocal varsofttabstop=
setlocal vartabstop=
setlocal virtualedit=
setlocal winbar=
setlocal winblend=0
setlocal nowinfixbuf
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal winhighlight=Visual:Visual,CursorLineFold:CursorLineFold,CursorLineSign:CursorLineSign,CursorLineNr:CursorLineNr,CursorLine:CursorLine
setlocal nowrap
setlocal wrapmargin=0
silent! normal! zE
let &fdl = &fdl
let s:l = 144 - ((21 * winheight(0) + 22) / 44)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 144
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 40 + 118) / 236)
exe 'vert 2resize ' . ((&columns * 116 + 118) / 236)
exe 'vert 3resize ' . ((&columns * 78 + 118) / 236)
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
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
