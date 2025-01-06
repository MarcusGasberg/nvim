local fmt = require("utils.icons").fmt
local icons = require("utils.icons").icons

require("lsp.cmp")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, {
	desc = fmt("Fix", "Next [d]iagnostics"),
})
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = fmt("Fix", "Previous [d]iagnostics") })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local nmap = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		local nimap = function(keys, func, desc)
			vim.keymap.set({ "n", "i" }, keys, func, { buffer = event.buf, desc = desc })
		end

		nmap("gd", require("telescope.builtin").lsp_definitions, fmt("Code", "[G]oto [D]efinition"))
		nmap("gr", vim.lsp.buf.references, fmt("Code", "[G]oto [R]eferences"))
		nmap("gI", require("telescope.builtin").lsp_implementations, fmt("Code", "[G]oto [I]mplementation"))
		nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, fmt("Code", "Type [D]efinition"))
		nmap("<leader>sy", require("telescope.builtin").lsp_document_symbols, fmt("Symbol", "Document [S][y]mbols"))
		nmap(
			"<leader>ws",
			require("telescope.builtin").lsp_dynamic_workspace_symbols,
			fmt("Symbol", "[W]orkspace [S]ymbols")
		)
		nmap("<leader>rn", vim.lsp.buf.rename, fmt("Fix", "[R]e[n]ame"))
		-- map("<leader>a", vim.lsp.buf.code_action, fmt("Fix", "Code [A]ction"))
		nmap("K", vim.lsp.buf.hover, fmt("Hint", "Hover Documentation"))
		nimap("<C-k>", vim.lsp.buf.signature_help, fmt("Hint", "Signature [K]elp"))
		nmap("gD", vim.lsp.buf.declaration, fmt("Code", "[G]oto [D]eclaration"))
		vim.keymap.set("n", "<leader>a", '<cmd>lua require("fastaction").code_action()<CR>', { buffer = event.buf })
		vim.keymap.set(
			"v",
			"<leader>a",
			"<esc><cmd>lua require('fastaction').range_code_action()<CR>",
			{ buffer = event.buf }
		)

		nmap("<leader>=", function(args)
			require("conform").format({
				lsp_format = "fallback",
				timeout = 5000,
			})
		end, fmt("Format", "Format"))

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		-- local client = vim.lsp.get_client_by_id(event.data.client_id)
		-- if client and client.server_capabilities.documentHighlightProvider then
		-- 	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		-- 		buffer = event.buf,
		-- 		group = "lsp-attach",
		-- 		callback = vim.lsp.buf.document_highlight,
		-- 	})
		--
		-- 	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		-- 		buffer = event.buf,
		-- 		group = "lsp-attach",
		-- 		callback = vim.lsp.buf.clear_references,
		-- 	})
		-- end
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
local cmp_capabillities = require("cmp_nvim_lsp").default_capabilities(normal_capabilities)

local capabilities = vim.tbl_deep_extend("force", cmp_capabillities, {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
	workspace = {
		didChangeWatchedFiles = {
			dynamicRegistration = false,
		},
	},
})
capabilities.textDocument.completion.completionItem.snippetSupport = true

local mason_config_ok, mason_config = pcall(require, "mason-lspconfig")
local mason_ok, mason = pcall(require, "mason")

if not (mason_ok and mason_config_ok) then
	print("LSPConfig, and/or Mason not installed!")
	return
end

mason.setup({
	providers = {
		"mason.providers.client",
		"mason.providers.registry-api",
	},
})

local servers = {
	"lua_ls",
	"angularls",
}

mason_config.setup({
	ensure_installed = servers,
})

mason_config.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		local server = require("lspconfig")[server_name]
		local server_status_ok, server_config = pcall(require, "lsp.servers." .. server_name)
		if not server_status_ok then
			-- print("The LSP '" .. server.name .. "' does not have a config.")
			server.setup({
				capabilities = capabilities,
			})
		else
			server_config.setup(capabilities, server)
		end
	end,
	["rust_analyzer"] = function()

	end,
	["jdtls"] = function()
		local workspace_path = vim.fn.stdpath("data") .. "/lsp_servers/jdtls_workspace_"
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = workspace_path .. project_name

		require("lspconfig").jdtls.setup({
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
				"-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
				"-jar",
				vim.fn.expand("$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
				"-configuration",
				vim.fn.expand("$MASON/share/jdtls/config"),
				"-data",
				workspace_dir,
			},
			capabilities = capabilities,
		})
	end,
	["kotlin_language_server"] = function()
		local server = require("lspconfig")["kotlin_language_server"]
		server.setup({
			capabilities = capabilities,
			root_dir = require("lspconfig").util.root_pattern(
				"settings.kts",
				"build.gradle.kts",
				"build.gradle",
				"pom.xml"
			),
		})
	end,
})

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

vim.o.foldcolumn = "0" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
