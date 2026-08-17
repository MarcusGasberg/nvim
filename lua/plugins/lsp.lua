local icons = require("utils.icons").icons
local fmt = require("utils.icons").fmt

return {
	{
		"saghen/blink.cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
					require("luasnip.loaders.from_vscode").lazy_load({ paths = "./my-snippets" })
				end,
			},
			{ "saghen/blink.lib" },
		},

		build = function()
			require("blink.cmp").build():pwait()
		end,
		cond = not vim.g.vscode,

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },

				["<CR>"] = { "accept", "fallback" },

				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			snippets = { preset = "luasnip" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = {
						score_offset = 4,
					},
					snippets = {
						min_keyword_length = 2,
						score_offset = 3,
					},
					path = {
						score_offset = 2,
					},
					buffer = {
						min_keyword_length = 5,
						score_offset = 1,
					},
				},
			},
			completion = {
				list = {
					selection = {
						auto_insert = function(ctx)
							return ctx.mode ~= "cmdline"
						end,
						preselect = function(ctx)
							return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active({ direction = 1 })
						end,
					},
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
			{ "Bilal2453/luvit-meta", lazy = true },
			-- {
			-- 	"pmizio/typescript-tools.nvim",
			-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
			-- },
			{
				"dmmulroy/tsc.nvim",
				config = function()
					require("tsc").setup({
						run_as_monorepo = true,
					})
				end,
			},
			{
				"pmizio/typescript-tools.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
				opts = {},
			},
		},
		event = { "BufReadPre", "BufNewFile" },
		cond = not vim.g.vscode,
		config = function()
			vim.lsp.log.set_level(vim.log.levels.OFF)
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, {
				desc = fmt("Fix", "Next [d]iagnostics"),
			})
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, { desc = fmt("Fix", "Previous [d]iagnostics") })

			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or "rounded"
				opts.max_width = opts.max_width or 80
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			-- Global diagnostic settings
			vim.diagnostic.config({
				severity_sort = true,
				update_in_insert = false,
				signs = {
					active = true,
					text = {
						[vim.diagnostic.severity.ERROR] = icons.Error,
						[vim.diagnostic.severity.WARN] = icons.Warn,
						[vim.diagnostic.severity.HINT] = icons.Hint,
						[vim.diagnostic.severity.INFO] = icons.Info,
					},
				},
				float = {
					header = "",
					source = true,
					border = "rounded",
					focusable = true,
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local buffer_opts = { buffer = event.buf }
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ border = "rounded" })
					end, buffer_opts)
					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition()
					end, buffer_opts)
					vim.keymap.set("n", "gD", function()
						vim.lsp.buf.declaration()
					end, buffer_opts)
					vim.keymap.set({ "n", "i" }, "<C-k>", function()
						vim.lsp.buf.signature_help()
					end, buffer_opts)
					vim.keymap.set("n", "<leader>vd", function()
						vim.diagnostic.open_float({ border = "rounded" })
					end, { desc = "View Diagnostics" })
					vim.keymap.set("n", "<leader>rn", function()
						vim.lsp.buf.rename()
					end, buffer_opts)
					vim.keymap.set("n", "<leader>ca", function()
						vim.lsp.buf.code_action()
					end, buffer_opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, buffer_opts)
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, buffer_opts)

					vim.keymap.set("n", "<leader>=", function()
						require("conform").format()
					end, buffer_opts)

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client == nil then
						return
					end
					if client.server_capabilities.documentHighlightProvider then
						client.server_capabilities.documentHighlightProvider = false
					end
				end,
			})

			local mason_settings = require("mason.settings")
			local install_location = mason_settings.current.install_root_dir

			local servers = {
				lua_ls = true,
				eslint = true,
				tailwindcss = {
					cmd = { "tailwindcss-language-server", "--stdio" },
					capabilities = {
						workspace = {
							-- lspconfig force-enables this for tailwindcss; without an async watch
							-- backend (inotifywait/fswatch) nvim falls back to a synchronous scan of
							-- the whole workspace per registration, freezing the UI ~10s x3 in large
							-- monorepos. Trade-off: tailwind config changes need :LspRestart.
							didChangeWatchedFiles = {
								dynamicRegistration = false,
							},
						},
					},
					filetypes = {
						"aspnetcorerazor",
						"astro",
						"astro-markdown",
						"angular",
						"blade",
						"django-html",
						"edge",
						"eelixir",
						"elixir",
						"heex",
						"ejs",
						"erb",
						"eruby",
						"gohtml",
						"haml",
						"handlebars",
						"hbs",
						"html",
						"html-eex",
						"heex",
						"jade",
						"leaf",
						"liquid",
						"markdown",
						"mdx",
						"mustache",
						"njk",
						"nunjucks",
						"php",
						"razor",
						"slim",
						"twig",
						"css",
						"less",
						"postcss",
						"sass",
						"scss",
						"stylus",
						"sugarss",
						"javascript",
						"javascriptreact",
						"reason",
						"rescript",
						"typescript",
						"typescriptreact",
						"vue",
						"svelte",
					},
					init_options = {
						userLanguages = {
							eelixir = "html-eex",
							elixir = "html-eex",
							eruby = "erb",
						},
					},
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									{ "cva\\(((?:[^()]|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
									{ "cx\\(((?:[^()]|\\([^()]*\\))*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
								},
							},
						},
					},
				},
				angularls = true,
				jdtls = {
					cmd = {
						"java",
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=true",
						"-Dlog.level=ALL",
						"-Xms1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",
						"-javaagent:" .. install_location .. "/share/jdtls/lombok.jar",
						"-jar",
						install_location .. "/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
						"-configuration",
						install_location .. "/share/jdtls/config",
						"-data",
						vim.fn.stdpath("data")
							.. "/lsp_servers/jdtls_workspace_"
							.. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
					},
					settings = {
						java = {
							format = {
								enabled = true,
								settings = {
									url = vim.fn.expand("~/.config/nvim/lua/plugins/formatters/DPM_Code_Style.xml"),
									profile = "DPM Code Style",
								},
							},
							completion = {
								importOrder = { "java", "javax", "org", "com", "" },
							},
							saveActions = {
								organizeImports = true,
							},
						},
					},
				},
				jsonls = {
					server_capabilities = {
						documentFormattingProvider = false,
					},
				},
				["cucumber_language_server"] = true,
				cssls = {
					server_capabilities = {
						documentFormattingProvider = false,
					},
				},
			}

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			local server_names = vim.tbl_keys(servers)

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				local lsp_config = vim.tbl_deep_extend("force", {}, config)
				lsp_config.server_capabilities = nil
				if next(lsp_config) ~= nil then
					vim.lsp.config(name, lsp_config)
				end
				vim.lsp.enable(name)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "Apply per-server capability overrides",
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end
					local settings = servers[client.name]
					if type(settings) == "table" and settings.server_capabilities then
						for k, v in pairs(settings.server_capabilities) do
							if v == vim.NIL then
								v = nil
							end
							client.server_capabilities[k] = v
						end
					end
				end,
			})

			vim.schedule(function()
				require("mason").setup()
				require("mason-lspconfig").setup({
					automatic_enable = false,
				})
				require("mason-tool-installer").setup({
					ensure_installed = vim.list_extend({
						"stylua",
						"prettierd",
						"eslint_d",
						"shfmt",
					}, server_names),
				})
			end)

			require("typescript-tools").setup({
				settings = {
					separate_diagnostic_server = true,
					publish_diagnostic_on = "insert_leave",
					jsx_close_tag = {
						enable = true,
						filetypes = { "javascriptreact", "typescriptreact" },
					},
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = true,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayEnumMemberValueHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeCompletionsForModuleExports = true,
						includeCompletionsForImportStatements = true,
					},
					tsserver_format_options = {
						insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
						semicolons = "insert",
					},
					complete_function_calls = true,
					include_completions_with_insert_text = true,
					code_lens = "off",
					disable_member_code_lens = true,
					tsserver_max_memory = 12288,
				},
			})
		end,
	},
}
