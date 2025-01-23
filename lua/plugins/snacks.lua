return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    -- notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    { "<C-x>",      function() Snacks.bufdelete() end,        desc = "Buf Delete" },
    { "<C-g>",      function() Snacks.lazygit() end,          desc = "Lazygit" },
    { "<C-t>",      function() Snacks.terminal() end,         desc = "Toggle Terminal" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
  }
}
