-- vim.api.nvim_exec('language en_US', true)
-- vim.opt.shell="pwsh"
-- vim.opt.shellcmdflag="-command"
-- vim.opt.shellquote="\""
-- vim.opt.shellxquote=""
-- set.leader to comma/space key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.g.wildmenu = true
-- vim.cmd[[ set wildmode=list:longest,full ]]
-- vim.g.wildmode = 'list:longest'
vim.g.wildignore = "**/node_modules/**"
-- update time for plugins (speed when they act)
vim.opt.updatetime = 100
--Mouse support active. Alt click
vim.opt.mouse = "a"
-- set.relative line numbers for jumping
vim.opt.relativenumber = true
-- Number of current line
vim.opt.number = true
-- Turn on clipboard across panes for tmux
vim.opt.regexpengine = 0
-- Let treesitter handle styling
-- vim.opt.clipboard += 'unnamedplus'
-- set substitute/replace command to automatically use global flag
vim.opt.gdefault = true
-- Do not allow line wraping
vim.opt.wrap = false
-- Start scrolling when you're 15 away from bottom (and side)
vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 35
-- Keep column for linting always on
vim.opt.signcolumn = "yes"
-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- Create splits vertically by default
vim.opt.diffopt = "vertical"
-- set no swap files
vim.opt.swapfile = false
vim.opt.backup = false
-- And use undodir instead
-- Allow undo-ing even after save file
vim.opt.undodir = vim.fn.stdpath("config") .. "/.undo"
vim.opt.undofile = true
-- Hide 'No write since last change' error on switching buffers Keeps buffer open in the background.
vim.opt.hidden = true
-- Control searching. Ignore case during search, except if it includes a capital letter
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.backspace = "indent,eol,start"

-- Session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Indenting
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.tabstop = 2
vim.opt.expandtab = true

-- filenames
vim.opt.fileformat = "unix"
vim.opt.fileformats = "unix,dos"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Fira Code Retina"

vim.g.t_Co = 256
vim.g.t_ut = nil

vim.opt.colorcolumn = "80"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"
