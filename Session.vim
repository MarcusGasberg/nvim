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
badd +2 ~/.config/nvim/lua/lsp/init.lua
badd +279 lua/plugins/init.lua
badd +121 lua/utils/icons.lua
badd +44 ~/.config/nvim/lua/plugins/telescope.lua
badd +25 lua/plugins/neotest.lua
badd +3 ~/.config/nvim/lua/utils/keymap.lua
badd +57 lua/plugins/gitsigns.lua
badd +3 lua/mappings.lua
badd +31 lua/plugins/trouble.lua
badd +75 lua/plugins/dap-ui.lua
badd +152 lua/plugins/snippets/my-snippets/angular.json
badd +734 ~/.config/nvim/lua/plugins/snippets/my-snippets/typescript.json
badd +174 ~/.config/nvim/lua/functions/utils.lua
badd +1 lua/plugins/treesitter.lua
badd +32 ~/source/repos/command-center/feature/LY-796-fdd0035-customer-account/apps/dashboard/src/app/organization/add-organization-node-dialog/add-organization-node-dialog.component.html
badd +124 lua/plugins/nvim-dap.lua
badd +1 ~/.config/nvim/lua/lsp/servers/tailwindcss.lua
badd +2 ~/.config/nvim/lua/lsp/servers/sumneko_lua.lua
badd +1 ~/.config/nvim/lua/lsp/servers/emmet_language_server.lua
badd +4 ~/.config/nvim/lua/lsp/servers/angularls.lua
badd +106 ~/.config/nvim/lua/lsp/cmp.lua
badd +1 ~/.local/state/nvim/lsp.log
badd +4 lua/plugins/color-schemes/rose-pine.lua
badd +5 lua/plugins/oil.lua
badd +1 ~/.config/nvim/lua/plugins/sql.lua
badd +1 lua/plugins/lint.lua
badd +52 lua/autocommands.lua
badd +16 lua/plugins/conform.lua
badd +19 lua/plugins/copilot.lua
badd +1 ~/.config/nvim/lua/lsp/servers/omnisharp.lua
badd +52 ~/.config/nvim/lua/plugins/typescript-tools.lua
badd +26 ~/.config/nvim/lua/plugins/noice.lua
badd +36 lua/plugins/mini.lua
badd +1 health://
badd +16 ~/.config/nvim/lua/lsp/servers/ts_ls.lua
badd +7 ~/.config/nvim/lua/vscode-mappings.lua
badd +9 ~/.config/nvim/init.lua
argglobal
%argdel
edit ~/.config/nvim/lua/vscode-mappings.lua
argglobal
balt ~/.config/nvim/init.lua
let s:cpo_save=&cpo
set cpo&vim
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
setlocal colorcolumn=80
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
setlocal shiftwidth=2
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
setlocal statusline=%#lualine_transitional_lualine_a_normal_to_StatusLine#%#lualine_a_normal#\ NORMAL\ %#lualine_b_normal#\ vscode-mappings.lua\ |%#lualine_b_normal#\ \ master\ %#lualine_transitional_lualine_b_normal_to_lualine_c_normal#%<%#lualine_c_normal#\ 󰛢\ \ 1\ \ %#lualine_c_normal#%=%#lualine_transitional_lualine_y_filetype_DevIconLua_normal_to_lualine_c_normal#%#lualine_y_filetype_DevIconLua_normal#\ \ %#lualine_b_normal#lua\ %#lualine_b_normal#|%#lualine_b_normal#\ Bot\ %#lualine_a_normal#\ \ \ 7:87\ %#lualine_transitional_lualine_a_normal_to_StatusLine#
setlocal suffixesadd=.lua
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != ''
setlocal syntax=
endif
setlocal tabstop=8
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
setlocal winhighlight=
setlocal nowrap
setlocal wrapmargin=0
silent! normal! zE
let &fdl = &fdl
let s:l = 7 - ((6 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 7
normal! 087|
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
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
