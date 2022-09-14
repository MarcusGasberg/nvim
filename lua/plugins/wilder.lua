vim.cmd([[
  call wilder#setup({'modes': [':', '/', '?']})

  call wilder#set_option('renderer', wilder#popupmenu_renderer({
    \ 'highlighter': wilder#basic_highlighter(),
    \ 'highlights': {
      \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}]),
      \ },
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ }))


      call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
        \       'language': 'python',
        \       'fuzzy': 1,
        \     }),
        \     wilder#python_search_pipeline({
          \       'pattern': wilder#python_fuzzy_pattern(),
          \       'sorter': wilder#python_difflib_sorter(),
          \       'engine': 're',
          \     }),
          \   ),
          \ ])

          call wilder#setup({
            \ 'modes': [':'],
            \ 'next_key': '<C-n>',
            \ 'previous_key': '<C-p>',
            \ 'accept_key': '<Down>',
            \ 'reject_key': '<Up>',
            \ })
]])
-- This doesn't work with incsearch...
-- local wilder = require("wilder")
-- wilder.setup({ modes = { ":", "/", "?" }})
--
-- wilder.set_option(
-- 	"renderer",
-- 	wilder.popupmenu_renderer({
-- 		highlighter = wilder.basic_highlighter(),
-- 		highlights = {
-- 			accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#f4468f" } }),
-- 			border = "Normal", -- highlight to use for the border
-- 		},
-- 		border = "rounded",
-- 		left = {
-- 			" ",
-- 			wilder.popupmenu_devicons(),
-- 		},
-- 		right = {
-- 			" ",
-- 			wilder.popupmenu_scrollbar(),
-- 		},
-- 	})
-- )
--
-- wilder.set_option("pipeline", {
-- 	wilder.branch(
-- 		-- wilder.python_file_finder_pipeline({
-- 		-- 	-- to use ripgrep : {'rg', '--files'}
-- 		-- 	-- to use fd      : {'fd', '-tf'}
-- 		-- 	file_command = { "fd", "-tf" },
-- 		-- 	-- to use fd      : {'fd', '-td'}
-- 		-- 	dir_command = { "fd", "-td" },
-- 		-- 	-- use {'cpsm_filter'} for performance, requires cpsm vim plugin
-- 		-- 	-- found at https://github.com/nixprime/cpsm
-- 		-- 	filters = { "fuzzy_filter", "difflib_sorter" },
-- 		-- }),
-- 		wilder.cmdline_pipeline({
-- 			language = "python",
-- 			fuzzy = 1, 
-- 		}),
-- 		wilder.python_search_pipeline({
-- 			-- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
-- 			pattern = wilder.python_fuzzy_pattern(),
-- 			-- omit to get results in the order they appear in the buffer
-- 			sorter = wilder.python_difflib_sorter(),
-- 			-- can be set to 're2' for performance, requires pyre2 to be installed
-- 			-- see :h wilder#python_search() for more details
-- 			engine = "re",
-- 		})
-- 	),
-- })
--
