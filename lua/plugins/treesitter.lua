-- For rainbow brackets
local disable_function = function(lang, bufnr)
  if not bufnr then
    bufnr = 0
  end
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  if line_count > 20000 then
    vim.g.matchup_matchparen_enabled = 0
    return true
  else
    vim.g.matchup_matchparen_enabled = 1
    return false
  end
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")
      require("nvim-treesitter.config").setup({})

      -- ensure_installed/auto_install/sync_install no longer exist on main;
      -- install() is a no-op for parsers that are already present.
      require("nvim-treesitter").install({
        "lua",
        "vim",
        "css",
        "javascript",
        "typescript",
        "go",
        "rust",
        "c_sharp",
        "scss",
        "json",
        "html",
        "markdown",
        "regex",
        "bash",
        "markdown_inline",
        "angular",
        "svelte",
        "python",
      })

      -- Treesitter highlighting is now built into Neovim.
      -- Enable it via an autocommand for all filetypes with a parser.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if disable_function(vim.bo[args.buf].filetype, args.buf) then
            return
          end
          if not vim.g.vscode then
            pcall(vim.treesitter.start, args.buf)
          end
        end,
      })
    end
  },
}
