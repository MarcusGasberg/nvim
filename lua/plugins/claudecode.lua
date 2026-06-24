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

    local keymap = require("utils.keymap")
    local fmt = require("utils.icons").fmt

    keymap.visual_map("<leader>as", "<cmd>ClaudeCodeSend<cr>", fmt("Copilot", "Send selection to Claude"))
    keymap.normal_map("<leader>ab", function()
      vim.cmd("ClaudeCodeAdd " .. vim.fn.expand("%:p"))
    end, fmt("Copilot", "Add buffer to Claude"))
    keymap.normal_map("<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", fmt("Copilot", "Accept Claude diff"))
    keymap.normal_map("<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", fmt("Copilot", "Deny Claude diff"))
    keymap.normal_map("<leader>af", function()
      require("utils.claude_diagnostic").send_current_line()
    end, fmt("Copilot", "Fix diagnostic with Claude"))
  end,
}
