-- nvim/lua/plugins/claudecode.lua
return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  cond = not vim.g.vscode,
  opts = {
    terminal = { provider = "external" },
  },
  cmd = {
    "ClaudeCode",
    "ClaudeCodeSend",
    "ClaudeCodeAdd",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
  },
  config = function(_, opts)
    require("claudecode").setup(opts)
  end,
}
