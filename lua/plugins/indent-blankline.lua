local indent_ok, indent = pcall(require, "ibl")

if not indent_ok then
	print("indent-blankline not found")
	return
end

indent.setup({
	indent = {
		char = "╎",
		smart_indent_cap = true,
	},
	scope = {
		enabled = false,
	},
})
