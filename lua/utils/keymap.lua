local M = {}

local normal_map = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end
M.normal_map = normal_map

local visual_map = function(keys, func, desc)
	vim.keymap.set("v", keys, func, { desc = desc })
end
M.visual_map = visual_map

return M
