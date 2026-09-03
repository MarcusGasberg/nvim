-- Highlight after yank
vim.cmd([[
  augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='Visual', timeout=300 }
  augroup END
]])

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
  pattern = { "*.component.html" },
  callback = function()
    vim.bo.filetype = "htmlangular"
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require("lint").try_lint()
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'lassie' then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
  end,
})

-- Re-apply the generated colorscheme when `retheme` signals us, so an open
-- editor repaints on a wallpaper change without a restart.
-- vim.schedule matters: signal handlers run in a restricted context and
-- :colorscheme triggers a full redraw.
vim.api.nvim_create_autocmd("Signal", {
  pattern = "SIGUSR1",
  group = vim.api.nvim_create_augroup("DynTheme", { clear = true }),
  callback = function()
    vim.schedule(function() pcall(vim.cmd.colorscheme, "dyn") end)
  end,
})
