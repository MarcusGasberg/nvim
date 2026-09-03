return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cond = not vim.g.vscode,
  config = function()
    require('oil').setup(
      {
        cleanup_delay_ms = 100,
        default_file_explorer = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          natural_order = true,
          -- Equivalent to VS Code's files.exclude: keep vendored reference repos
          -- out of the file explorer, even when hidden files are toggled on.
          is_always_hidden = function(name)
            return name == "repos"
          end,
        },
      })
    vim.keymap.set("n", "\\", "<cmd>Oil<cr>", { desc = "Open parent directory" })
  end
}
