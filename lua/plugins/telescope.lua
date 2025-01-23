local fmt = require("utils.icons").fmt;
local keymap = require("utils.keymap");

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    "isak102/telescope-git-file-history.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  lazy = false,
  opts = function()
    return {
      pickers = {
        find_files = {
          hidden = true,
        },
        git_files = {
          hidden = true,
        },
        buffers = {
          hidden = true,
          show_all_buffers = true,
          sort_lastused = true,
          theme = "dropdown",
          previewer = false,
          mappings = {
            i = {
              ["<c-x>"] = require("telescope.actions").delete_buffer,
            },
          },
        },

        current_buffer_fuzzy_find = {
          previewer = false,
          sorting_strategy = "ascending",
          prompt_prefix = " ",
        },
      },
      defaults = {
        file_ignore_patterns = { "node_modules", "package%-lock.json" },
        path_display = { "filename_first", "truncate" },
      },
      extensions = {
        fzf = {},
      },
    }
  end,
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")
  end,
  keys = {
    { "<C-p>",      "<cmd>Telescope git_files<cr>",  desc = "Find files" },
    { "<leader>fa", "<cmd>Telescope find_files<cr>", desc = "Find all files" },
    { "<leader>fi", "<cmd>Telescope live_grep<cr>",  desc = "Find in files" },
  },
}
