local context_ok, context = pcall(require, "nvim-treesitter-context")
if not context_ok then
	print("Treesitter context is not installed")
	return
end

context.setup()
