return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	cond = not vim.g.vscode,
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/snippets" })
	end
}
