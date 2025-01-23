local keymap = require("utils.keymap")
local icons = require("utils.icons").icons
local fmt = require("utils.icons").fmt

return {
	{
		"mfussenegger/nvim-dap",
		cond = not vim.g.vscode,
		config = function()
			local dap = require("dap")
			dap.set_log_level("INFO")

			-- local netcoredbg = mason_registry.get_package("netcoredbg")
			--
			-- local netcoredbg_path = netcoredbg:get_install_path()
			--
			-- dap.adapters.coreclr = {
			-- 	type = "executable",
			-- 	command = netcoredbg_path .. "/netcoredbg/netcoredbg",
			-- 	args = { "--interpreter=vscode" },
			-- }
			-- dap.configurations.cs = {
			-- 	{
			-- 		name = "launch - netcoredbg",
			-- 		type = "coreclr",
			-- 		request = "launch",
			-- 		preLaunchTask = "build",
			-- 		program = "${workspaceFolder}/Sirene3API/bin/Debug/net5.0/Sirene3API.dll",
			-- 		args = {},
			-- 		cwd = "${workspaceFolder}/Sirene3API",
			-- 		stopAtEntry = false,
			-- 		env = {
			-- 			ASPNETCORE_ENVIRONMENT = "Development",
			-- 		},
			-- 	},
			-- }

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					-- 💀 Make sure to update this path to point to your installation
					args = { "/bin/js-debug/src/dapDebugServer.js", "${port}" },
				},
			}

			local exts = {
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				-- using pwa-chrome
				"vue",
				"svelte",
			}

			for i, ext in ipairs(exts) do
				dap.configurations[ext] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node)",
						cwd = vim.fn.getcwd(),
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node with ts-node)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "--loader", "ts-node/esm" },
						runtimeExecutable = "node",
						args = { "${file}" },
						sourceMaps = true,
						protocol = "inspector",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Current File (pwa-node with deno)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
						runtimeExecutable = "deno",
						attachSimplePort = 9229,
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with jest)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
						runtimeExecutable = "node",
						args = { "${file}", "--coverage", "false" },
						rootPath = "${workspaceFolder}",
						sourceMaps = true,
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with vitest)",
						cwd = vim.fn.getcwd(),
						program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
						args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
						autoAttachChildProcesses = true,
						smartStep = true,
						console = "integratedTerminal",
						skipFiles = { "<node_internals>/**", "node_modules/**" },
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch Test Current File (pwa-node with deno)",
						cwd = vim.fn.getcwd(),
						runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
						runtimeExecutable = "deno",
						attachSimplePort = 9229,
					},
					{
						type = "pwa-chrome",
						request = "attach",
						name = "Attach Program (pwa-chrome = { port: 9222 })",
						program = "${file}",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						port = 9222,
						webRoot = "${workspaceFolder}",
					},
					{
						type = "node2",
						request = "attach",
						name = "Attach Program (Node2)",
						processId = require("dap.utils").pick_process,
					},
					{
						type = "node2",
						request = "attach",
						name = "Attach Program (Node2 with ts-node)",
						cwd = vim.fn.getcwd(),
						sourceMaps = true,
						skipFiles = { "<node_internals>/**" },
						port = 9229,
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach Program (pwa-node)",
						cwd = vim.fn.getcwd(),
						processId = require("dap.utils").pick_process,
						skipFiles = { "<node_internals>/**" },
					},
				}
			end
		end
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")

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
		end,
		cond = not vim.g.vscode,
		opts = {
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
		}
	}
}
