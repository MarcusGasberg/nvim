local keymap = require("utils.keymap")
local fmt = require("utils.icons").fmt

return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  cond = not vim.g.vscode,
  config = function()
    require('copilot').setup({
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>"
        },
        layout = {
          position = "bottom", -- | top | left | right | horizontal | vertical
          ratio = 0.4
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = true,
        debounce = 75,
        trigger_on_accept = true,
        keymap = {
          accept = "<M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      auth_provider_url = nil,       -- URL to authentication provider, if not "https://github.com/"
      copilot_node_command = 'node', -- Node.js version must be > 20
      workspace_folders = {},
      copilot_model = "",            -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
      root_dir = function()
        return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
      end,
      server = {
        type = "nodejs", -- "nodejs" | "binary"
        custom_server_filepath = nil,
      },
      server_opts_overrides = {},
    })

    keymap.normal_map("<leader>cpa", function()
      require("copilot.suggestion").toggle_auto_trigger()
    end, fmt("Copilot", "Toggle Copilot"))

    keymap.normal_map("<leader>cpo", function()
      require("copilot.panel").toggle()
    end, fmt("Copilot", "Toggle Copilot Panel"))
  end,
}
