local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
	print("Luasnip is not installed")
	return
end

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip/loaders/from_vscode").lazy_load({paths = "./snippets"})
