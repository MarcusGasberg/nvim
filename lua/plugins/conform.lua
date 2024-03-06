require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		markdown = { "vale" },
		sh = { "shfmt" },
		javascript = { "eslint_d", { "prettierd", "prettier" } },
		typescript = { "eslint_d", { "prettierd", "prettier" } },
		angular = { { "prettierd", "prettier" } },
		json = { { "prettierd", "prettier" } },
		html = { { "prettierd", "prettier" } },
		scss = { { "prettierd", "prettier" } },
		css = { { "prettierd", "prettier" } },
	},
	format_on_save = {
		timeout_ms = 1000,
		quiet = true,
	},
})
