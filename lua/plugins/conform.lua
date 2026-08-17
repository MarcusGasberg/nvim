return {
	"stevearc/conform.nvim",
	cond = not vim.g.vscode,
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			markdown = { "vale" },
			sh = { "shfmt" },
			javascript = { "eslint_d", "prettierd" },
			typescript = { "eslint_d", "prettierd" },
			typescriptreact = { "eslint_d", "prettierd" },
			angular = { "prettierd", "prettier", stop_after_first = true },
			json = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			htmlangular = { "prettierd", "prettier", stop_after_first = true },
			scss = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			graphql = { "prettierd", "prettier", stop_after_first = true },
			rust = { "rustfmt" },
			-- java = { "google-java-format" },
		},
		-- formatters = {
		-- 	["google-java-format"] = {
		-- 		command = "google-java-format",
		-- 		args = { "--aosp", "-" },
		-- 		stdin = true,
		-- 	},
		-- },
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_on_save = function(bufnr)
			-- Don't auto-format Java on save: jdtls reformats the whole file
			-- using the Eclipse profile, which churns untouched lines.
			-- Manual formatting (<leader>=) still works.
			if vim.bo[bufnr].filetype == "java" then
				return nil
			end
			return {
				timeout_ms = 1000,
				quiet = true,
			}
		end,
	},
}
