return {
  "brenoprata10/nvim-highlight-colors",
  enabled = not vim.g.vscode,
  setup = function()
    require('nvim-highlight-colors').setup({})
  end
}
