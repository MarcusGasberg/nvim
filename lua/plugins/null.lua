local u = require("functions.utils")

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
	formatting.prettierd,
	formatting.eslint_d,
	formatting.stylua,
	formatting.csharpier,
	diagnostics.eslint_d,
	code_actions.eslint_d,
}

null_ls.setup({
	debug = false,
	sources = sources,
	timeout = 5000,
})
