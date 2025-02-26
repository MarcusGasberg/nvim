local fmt = require("utils.icons").fmt
local keymap = require("utils.keymap")

return {
  "nvim-neotest/neotest",
  dependencies = {
    "haydenmeade/neotest-jest",
    "nvim-neotest/neotest-vim-test",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/nvim-nio",
  },
  cond = not vim.g.vscode,
  config = function()
    require("neotest").setup({
      discovery = {
        enabled = false,
      },
      icons = {
        expanded = "",
        child_prefix = "",
        child_indent = "",
        final_child_prefix = "",
        non_collapsible = "",
        collapsed = "",

        passed = "",
        running = "",
        failed = "",
        unknown = "",
        running_animated = { "◴", "◷", "◶", "◵" },
      },

      adapters = {
        require("neotest-jest")({
          jestCommand = "jest",
          jestConfigFile = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/libs|apps/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
            end

            return vim.fn.getcwd() .. "/jest.config.ts"
          end,
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-vim-test")({ ignore_filetypes = { "typescript" } }),
      },
    })

    keymap.normal_map(
      "<leader>tt",
      "<cmd>w<CR><cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
      fmt("Test", "[NeoTest] Test file")
    )
    keymap.normal_map(
      "<leader>ta",
      "<cmd>w<CR><cmd>lua require('neotest').run.run({ suite = true })<CR>",
      fmt("Test", "[NeoTest] Test suite")
    )
    keymap.normal_map(
      "<leader>tn",
      "<cmd>w<CR><cmd>lua require('neotest').run.run()<CR>",
      fmt("Test", "[NeoTest] Test nearest")
    )
    keymap.normal_map(
      "<leader>tl",
      "<cmd>w<CR><cmd>lua require('neotest').run.run_last()<CR>",
      fmt("Test", "[NeoTest] Test latest")
    )
    keymap.normal_map(
      "<leader>to",
      "<cmd>w<CR><cmd>lua require('neotest').output.open()<CR>",
      fmt("Open", "[NeoTest] Open test output")
    )
    keymap.normal_map(
      "<leader>tp",
      "<cmd>w<CR><cmd>lua require('neotest').output_panel.toggle()<CR>",
      fmt("Toggle", "[NeoTest] Toggle test output panel")
    )
    keymap.normal_map(
      "<leader>ts",
      "<cmd>w<CR><cmd>lua require('neotest').summary.toggle()<CR>",
      fmt("Toggle", "[NeoTest] Toggle test summary")
    )
    keymap.normal_map("<leader>td", function()
      vim.cmd("w")
      require("neotest").run.run({ strategy = "dap" })
    end, fmt("Debugger", "[NeoTest] Debug test"))
  end
}
