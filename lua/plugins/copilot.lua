-- disable copilot by default
vim.g.copilot_enabled = false

local map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = "COPILOT: " .. desc })
end

map("<leader>cp", function()
	vim.g.copilot_enabled = not vim.g.copilot_enabled
	if vim.g.copilot_enabled then
		vim.notify("Copilot enabled", 1, { title = "COPILOT" })
	else
		vim.notify("Copilot disabled", 1, { title = "COPILOT" })
	end
end, "Toggle")
