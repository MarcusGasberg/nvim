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
badd +103 nvim/lua/lsp/init.lua
badd +485 nvim/lua/plugins/init.lua
badd +26 nvim/lua/utils/icons.lua
badd +44 nvim/lua/plugins/telescope.lua
badd +25 nvim/lua/plugins/neotest.lua
badd +5 nvim/lua/utils/keymap.lua
badd +57 nvim/lua/plugins/gitsigns.lua
badd +2 nvim/lua/mappings.lua
badd +31 nvim/lua/plugins/trouble.lua
badd +60 nvim/lua/plugins/dap-ui.lua
badd +835 nvim/lua/plugins/snippets/my-snippets/typescript.json
badd +174 nvim/lua/functions/utils.lua
badd +1 nvim/lua/plugins/treesitter.lua
badd +32 ~/source/repos/command-center/feature/LY-796-fdd0035-customer-account/apps/dashboard/src/app/organization/add-organization-node-dialog/add-organization-node-dialog.component.html
badd +124 nvim/lua/plugins/nvim-dap.lua
badd +1 nvim/lua/lsp/servers/tailwindcss.lua
badd +2 nvim/lua/lsp/servers/sumneko_lua.lua
badd +1 nvim/lua/lsp/servers/emmet_language_server.lua
badd +8 nvim/lua/lsp/servers/angularls.lua
badd +1 nvim/lua/lsp/cmp.lua
badd +8 nvim/lua/plugins/color-schemes/rose-pine.lua
badd +5 nvim/lua/plugins/oil.lua
badd +1 nvim/lua/plugins/sql.lua
badd +5 nvim/lua/plugins/lint.lua
badd +49 nvim/lua/autocommands.lua
badd +14 nvim/lua/plugins/conform.lua
badd +19 nvim/lua/plugins/copilot.lua
badd +1 nvim/lua/lsp/servers/omnisharp.lua
badd +52 nvim/lua/plugins/typescript-tools.lua
badd +1 nvim/lua/plugins/noice.lua
badd +1 nvim/lua/plugins/mini.lua
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
badd +1 nvim/lua/settings.lua
badd +23 nvim/lua/plugins/toggleterm.lua
badd +13 nvim/lua/plugins/lualine.lua
badd +72 tmux/tmux.conf
badd +1 /tmp/nvim.maga/3jBOye/prov-events-devicestatechange-List-2024-10-15-08-19-44
badd +1 /tmp/nvim.maga/3jBOye/prov-events-connectionchange-List-2024-10-15-08-19-57
badd +14 nvim/lua/plugins/rust.lua
badd +1 /tmp/nvim.maga/227keC/postgres-tasks-task-List-2024-10-16-06-45-10
badd +1 /tmp/nvim.maga/227keC/postgres-device-pump-List-2024-10-16-10-31-37
badd +1 /tmp/nvim.maga/227keC/postgres-tasks-task-List-2024-10-16-10-36-27
badd +1 /tmp/nvim.maga/227keC/postgres-device-pump-List-2024-10-16-10-37-27
badd +1 /tmp/nvim.maga/227keC/postgres-device-device-List-2024-10-16-10-37-50
badd +1 /tmp/nvim.maga/227keC/postgres-device-pump-List-2024-10-16-10-39-15
badd +1 ~/.config/nvim/lua/utils/regmove.lua
badd +15 ~/.config/nvim/lua/plugins/snippets/my-snippets/scss.json
badd +1 ~/.config/nvim/lua/plugins/snippets/my-snippets/jsonc.json
badd +1 ~/.config/nvim/lua/plugins/snippets/my-snippets/javascript.json
badd +2 ~/.config/nvim/lua/plugins/snippets/my-snippets/elixir.json
badd +60 ~/.config/nvim/lua/plugins/snippets/package.json
badd +235 ~/.config/nvim/lua/plugins/snippets/my-snippets/htmlangular.json
badd +80 ~/.config/nvim/lua/plugins/copilot-chat.lua
argglobal
%argdel
edit nvim/lua/plugins/init.lua
argglobal
balt ~/.config/nvim/lua/plugins/copilot-chat.lua
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
setlocal cursorline
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
setlocal statusline=%#lualine_transitional_lualine_a_command_to_StatusLine#%#lualine_a_command#\ COMMAND\ %#lualine_b_command#\ init.lua\ %#lualine_transitional_lualine_b_command_to_lualine_c_normal#%<%#lualine_c_normal#%=%#lualine_transitional_lualine_y_filetype_DevIconLua_command_to_lualine_c_normal#%#lualine_y_filetype_DevIconLua_command#\ \ %#lualine_b_command#lua\ %#lualine_b_command#|%#lualine_b_command#\ 98%%\ %#lualine_a_command#\ 485:5\ \ %#lualine_transitional_lualine_a_command_to_StatusLine#
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
let s:l = 485 - ((24 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 485
normal! 08|
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
