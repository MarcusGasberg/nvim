require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		html = { { "prettierd", "prettier" } },
		scss = { { "prettierd", "prettier" } },
	},
	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
	},
})
