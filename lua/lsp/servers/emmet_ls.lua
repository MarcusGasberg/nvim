return {
  setup = function(common_on_attach, capabilities, server)
    server.setup({
      on_attach = common_on_attach,
      filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug",
        "elixir",
        "heex",
        "leex",
        "typescriptreact", "vue" },
      capabilities,
    })
  end,
}
