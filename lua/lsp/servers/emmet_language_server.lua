return {
	setup = function(capabilities, server)
		server.setup({
			filetypes = {
				"css",
				"eruby",
				"html",
				"javascript",
				"javascriptreact",
				"less",
				"sass",
				"scss",
				"svelte",
				"pug",
				"elixir",
				"heex",
				"leex",
				"typescriptreact",
				"vue",
			},
			capabilities,
		})
	end,
}
