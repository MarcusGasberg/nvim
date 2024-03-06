-- For rainbow brackets
local disable_function = function(lang, bufnr)
	if not bufnr then
		bufnr = 0
	end
	local line_count = vim.api.nvim_buf_line_count(bufnr)
	if line_count > 20000 then
		vim.g.matchup_matchparen_enabled = 0
		return true
	else
		vim.g.matchup_matchparen_enabled = 1
		return false
	end
end

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"css",
		"javascript",
		"typescript",
		"go",
		"rust",
		"c_sharp",
		"scss",
		"json",
		"html",
		"markdown",
		"regex",
		"bash",
		"markdown_inline",
		"angular",
	},
	sync_install = false,
	ignore_install = { "haskell", "phpdoc", "jsdoc", "comment" },
	highlight = {
		enable = not vim.g.vscode, -- false will disable the whole extension
		disable = disable_function,
		additional_vim_regex_highlighting = false,
	},
	matchup = {
		enable = false,
		disable = { "json", "csv" },
	},
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
			},
			-- You can choose the select mode (default is charwise 'v')
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * method: eg 'v' or 'o'
			-- and should return the mode ('v', 'V', or '<c-v>') or a table
			-- mapping query_strings to modes.
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding or succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in
			-- `ap`.
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * selection_mode: eg 'v'
			-- and should return true of false
			include_surrounding_whitespace = true,
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["}"] = "@function.outer",
				["]]"] = { query = "@class.outer", desc = "Next class start" },
			},
			goto_next_end = {
				-- ["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["{"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
		filetypes = {
			"html",
			"angular",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"tsx",
			"jsx",
			"rescript",
			"xml",
			"php",
			"markdown",
			"astro",
			"glimmer",
			"handlebars",
			"hbs",
		},
	},
})
