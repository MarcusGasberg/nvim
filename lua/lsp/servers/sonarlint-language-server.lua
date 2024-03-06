return {
	setup = function(capabilities, server)
		server.setup({
			capabilities = capabilities,
			server = {
				cmd = {
					"sonarlint-language-server",
					-- Ensure that sonarlint-language-server uses stdio channel
					"-stdio",
					"-analyzers",
					-- paths to the analyzers you need, using those for python and java in this example
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
					vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarhtml.jar"),
				},
			},
			filetypes = {
				-- Requires nvim-jdtls, otherwise an error message will be printed
				"java",
				"typescript",
				"javascript",
			},
		})
	end,
}
