local keymap = require("utils.keymap")
local icons = require("utils.icons").icons
local fmt = require("utils.icons").fmt

local dap, dapui = require("dap"), require("dapui")
dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	expand_lines = vim.fn.has("nvim-0.7"),
	layouts = {
		{
			elements = {
				"scopes",
			},
			size = 0.3,
			position = "right",
		},
		{
			elements = {
				"repl",
				"breakpoints",
			},
			size = 0.3,
			position = "bottom",
		},
	},
	floating = {
		max_height = nil,
		max_width = nil,
		border = "single",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil,
	},
})
vim.fn.sign_define("DapBreakpoint", { text = icons.Breakpoint })

-- Start debugging session
keymap.normal_map("<leader>ds", function()
	dap.continue()
	dapui.toggle({})
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end, fmt("Debugger", "Debug start"))

-- Set breakpoints, get variable values, step into/out of functions, etc.
keymap.normal_map("<leader>dl", require("dap.ui.widgets").hover, fmt("Debugger", "Debug hover"))
keymap.normal_map("<leader>dc", require("dap").continue, fmt("Continue", "Continue"))
keymap.normal_map("<leader>db", require("dap").toggle_breakpoint, fmt("Breakpoint", "Breakpoint"))
keymap.normal_map("<leader>dn", require("dap").step_over, fmt("StepOver", "Step over"))
keymap.normal_map("<leader>di", require("dap").step_into, fmt("StepInto", "Step into"))
keymap.normal_map("<leader>do", require("dap").step_out, fmt("StepOut", "Step out"))
keymap.normal_map("<leader>dr", require("dap").run_to_cursor, fmt("Continue", "Run to cursor"))
keymap.normal_map("<leader>dC", function()
	dap.clear_breakpoints()
end, fmt("Breakpoint", "Clear all breakpoints"))

keymap.normal_map("<leader>dx", function()
	require("dapui").close()
end, fmt("Breakpoint", "[x]lose debug UI"))

dap.listeners.before.attach.dapui_config = function()
	require("dapui").open()
end

dap.listeners.before.launch.dapui_config = function()
	require("dapui").open()
end

-- For some reason this closes dap ui when running jest adapter
-- dap.listeners.before.event_terminated.dapui_config = function()
-- 	require("dapui").close()
-- end

dap.listeners.before.event_exited.dapui_config = function()
	require("dapui").close()
end
