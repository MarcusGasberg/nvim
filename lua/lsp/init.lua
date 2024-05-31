local fmt = require("utils.icons").fmt

require("lsp.cmp")

vim.diagnostic.config({
	virtual_text = {
		severity = { min = vim.diagnostic.severity.WARN },
		prefix = "●",
	},
	float = {
		border = "rounded",
	},
	severity_sort = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
end)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		map("gd", require("telescope.builtin").lsp_definitions, fmt("Code", "[G]oto [D]efinition"))
		map("gr", vim.lsp.buf.references, fmt("Code", "[G]oto [R]eferences"))
		map("gI", require("telescope.builtin").lsp_implementations, fmt("Code", "[G]oto [I]mplementation"))
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, fmt("Code", "Type [D]efinition"))
		map("<leader>sy", require("telescope.builtin").lsp_document_symbols, fmt("Symbol", "Document [S][y]mbols"))
		map(
			"<leader>ws",
			require("telescope.builtin").lsp_dynamic_workspace_symbols,
			fmt("Symbol", "[W]orkspace [S]ymbols")
		)
		map("<leader>rn", vim.lsp.buf.rename, fmt("Fix", "[R]e[n]ame"))
		-- map("<leader>a", vim.lsp.buf.code_action, fmt("Fix", "Code [A]ction"))
		map("K", vim.lsp.buf.hover, fmt("Hint", "Hover Documentation"))
		map("<C-k>", vim.lsp.buf.signature_help, fmt("Hint", "Signature [K]elp"))
		map("gD", vim.lsp.buf.declaration, fmt("Code", "[G]oto [D]eclaration"))

		map("<leader>=", function(args)
			require("conform").format({
				lsp_fallback = true,
				timeout = 5000,
			})
		end, fmt("Format", "Format"))

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = "lsp-attach",
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = "lsp-attach",
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	opts.max_width = opts.max_width or 80
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local normal_capabilities = vim.lsp.protocol.make_client_capabilities()
normal_capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

local capabilities = nil
local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if cmp_nvim_lsp_status_ok then
	cmp_nvim_lsp.default_capabilities(normal_capabilities)
end

local servers = {
	lua_ls = {},
	["nil_ls"] = {
	}
}

for server_name, opts in pairs(servers) do
	config = vim.tbl_deep_extend("force", {}, {
		capabilities = capabilities,
	}, opts)
	require('lspconfig')[server_name].setup(config)
end

-- local mason_config_ok, mason_config = pcall(require, "mason-lspconfig")
-- local mason_ok, mason = pcall(require, "mason")
--
-- if not (mason_ok and mason_config_ok) then
-- 	print("LSPConfig, and/or Mason not installed!")
-- 	return
-- end
--
-- mason.setup({
-- 	providers = {
-- 		"mason.providers.client",
-- 		"mason.providers.registry-api",
-- 	},
-- })
--
--
-- mason_config.setup({
-- 	ensure_installed = servers,
-- })
--
-- mason_config.setup_handlers({
-- 	-- The first entry (without a key) will be the default handler
-- 	-- and will be called for each installed server that doesn't have
-- 	-- a dedicated handler.
-- 	function(server_name) -- default handler (optional)
-- 		local server = require("lspconfig")[server_name]
-- 		local server_status_ok, server_config = pcall(require, "lsp.servers." .. server_name)
-- 		if not server_status_ok then
-- 			-- print("The LSP '" .. server.name .. "' does not have a config.")
-- 			server.setup({
-- 				capabilities = capabilities,
-- 			})
-- 		else
-- 			server_config.setup(capabilities, server)
-- 		end
-- 	end,
-- 	-- -- Next, you can provide targeted overrides for specific servers.
-- 	-- -- For example, a handler override for the `rust_analyzer`:
-- 	["rust_analyzer"] = function()
-- 		local rt_ok, rt = pcall(require, "rust-tools")
--
-- 		local server = require("lspconfig")["rust_analyzer"]
-- 		server.setup({
-- 			capabilities = capabilities,
-- 		})
-- 		return rt.setup({
-- 			capabilities = capabilities,
-- 			server = {
-- 				on_attach = function(client, bufnr)
-- 					-- Hover actions
-- 					vim.keymap.set("n", "<C-K>", rt.hover_actions.hover_actions, { buffer = bufnr })
-- 					-- Code action groups
-- 					vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
-- 				end,
-- 			},
-- 			procMacro = {
-- 				ignored = {
-- 					leptos_macro = {
-- 						-- optional: --
-- 						-- "component",
-- 						"server",
-- 					},
-- 				},
-- 			},
-- 		})
-- 	end,
-- 	["jdtls"] = function()
-- 		local workspace_path = vim.fn.stdpath("data") .. "/lsp_servers/jdtls_workspace_"
-- 		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- 		local workspace_dir = workspace_path .. project_name
--
-- 		require("lspconfig").jdtls.setup({
-- 			cmd = {
-- 				"java",
-- 				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
-- 				"-Dosgi.bundles.defaultStartLevel=4",
-- 				"-Declipse.product=org.eclipse.jdt.ls.core.product",
-- 				"-Dlog.protocol=true",
-- 				"-Dlog.level=ALL",
-- 				"-Xms1g",
-- 				"--add-modules=ALL-SYSTEM",
-- 				"--add-opens",
-- 				"java.base/java.util=ALL-UNNAMED",
-- 				"--add-opens",
-- 				"java.base/java.lang=ALL-UNNAMED",
-- 				"-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
-- 				"-jar",
-- 				vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
-- 				"-configuration",
-- 				vim.fn.expand("$MASON/share/jdtls/config"),
-- 				"-data",
-- 				workspace_dir,
-- 			},
-- 			capabilities = capabilities,
-- 		})
-- 	end,
-- 	["kotlin_language_server"] = function()
-- 		local server = require("lspconfig")["kotlin_language_server"]
-- 		server.setup({
-- 			on_attach = on_attach,
-- 			capabilities = capabilities,
-- 			root_dir = require("lspconfig").util.root_pattern(
-- 				"settings.kts",
-- 				"build.gradle.kts",
-- 				"build.gradle",
-- 				"pom.xml"
-- 			),
-- 		})
-- 	end,
-- })

-- Global diagnostic settings
vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	update_in_insert = false,
	float = {
		header = "",
		source = "always",
		border = "rounded",
		focusable = true,
	},
})

-- Change Error Signs in Gutter
local signs = { Error = "✘", Warn = " ", Hint = "", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
