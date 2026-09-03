return {
  {
    "echasnovski/mini.base16",
    lazy = false,
    priority = 1000,
    cond = not vim.g.vscode,
    config = function()
      -- colors/dyn.lua reads the matugen-generated palette and falls back to
      -- catppuccin on its own if the palette is missing.
      vim.cmd.colorscheme("dyn")
    end,
  },
  {
    -- Kept installed but lazy: it is the fallback colors/dyn.lua reaches for,
    -- and the escape hatch if the generated scheme disappoints. Switching back
    -- permanently is a one-line change to the colorscheme call above.
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    cond = not vim.g.vscode,
    opts = { flavour = "mocha", term_colors = true },
  },
}
