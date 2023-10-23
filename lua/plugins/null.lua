local u = require("functions.utils")

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion

require("mason-null-ls").setup({
  ensure_installed = {},
  automatic_installation = false,
  automatic_setup = true, -- Recommended, but optional
  handlers = {},
})

local sources = {
  formatting.prettierd.with({
    extra_filetypes = {
      "svelte",
    }
  }),
  formatting.eslint_d,
  formatting.stylua,
  formatting.csharpier,
  diagnostics.eslint_d,
  completion.tags,
}

null_ls.setup({
  debug = false,
  sources = sources,
  timeout = 5000,
})
