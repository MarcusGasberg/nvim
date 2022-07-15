-- For rainbow brackets
local enabled_list = { "clojure" }
local parsers = require("nvim-treesitter.parsers")

local disable_function = function(lang, bufnr)
	if not bufnr then
		bufnr = 0
	end
	local line_count = vim.api.nvim_buf_line_count(bufnr)
	if line_count > 20000 or (line_count == 1 and lang == "json") then
		vim.g.matchup_matchparen_enabled = 0
		return true
	else
		return false
	end
end

require("nvim-treesitter.configs").setup({
	ensure_installed = {"lua", "css", "javascript", "typescript", "go", "rust", "c_sharp", "scss", "json", "yaml", "html", "markdown" },
	sync_install = false,
	ignore_install = { "haskell", "phpdoc", "jsdoc", "comment" },
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = disable_function,
		additional_vim_regex_highlighting = false,
	},
	-- Rainbow parens plugin
	rainbow = {
		enable = true,
		-- Enable only for lisp like languages
		disable = vim.tbl_filter(function(p)
			local disable = true
			for _, lang in pairs(enabled_list) do
				if p == lang then
					disable = false
				end
			end
			return disable
		end, parsers.available_parsers()),
	},
	matchup = {
		enable = true,
		disable = { "json", "csv" },
	},
})
