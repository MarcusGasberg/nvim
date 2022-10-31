local context_ok, context = pcall(require, "treesitter-context")
if !context_ok then
	print("Treesitter context is not installed")
	return
end

context.setup()
