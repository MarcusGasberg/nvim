vim.cmd("set termguicolors")
vim.cmd([[ :set signcolumn=yes ]])
vim.cmd([[ :hi NonText guifg=bg ]])

local kanagawa_ok, kanagawa = pcall(require, "kanagawa")
if not kanagawa_ok then
	print("Kanagawa is not installed.")
	return
end

kanagawa.setup({
    undercurl = true,           -- enable undercurls
    commentStyle = { italic = false },
    functionStyle = {},
    keywordStyle = { italic = false},
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = false  },
    specialReturn = true,       -- special highlight for the return keyword
    specialException = true,    -- special highlight for exception handling keywords
    transparent = false,        -- do not set background color
    dimInactive = false,        -- dim inactive window `:h hl-NormalNC`
    globalStatus = false,       -- adjust window separators highlight for laststatus=3
    terminalColors = true,      -- define vim.g.terminal_color_{0,17}
    colors = {},
    overrides = {},
})
vim.api.nvim_exec(
	[[
try
  colorscheme kanagawa
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]],
	true
)
