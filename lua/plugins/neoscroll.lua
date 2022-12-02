local t = {}
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "200" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "200" } }

local ts_ctx = require("treesitter-context")

require("neoscroll").setup({
	mappings = {},
	hide_cursor = true, -- Hide cursor while scrolling
	stop_eof = true, -- Stop at <EOF> when scrolling downwards
	use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
	respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	easing_function = "quadratic", -- Default easing function
	pre_hook = function(_) ts_ctx.disable() end,
	post_hook = function(_) ts_ctx.enable() end,
	performance_mode = false, -- Disable "Performance Mode" on all buffers.
})
require("neoscroll.config").set_mappings(t)
