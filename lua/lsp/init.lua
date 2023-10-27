local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local mason_config_ok, mason_config = pcall(require, "mason-lspconfig")
local mason_ok, mason = pcall(require, "mason")
local lsp_config_ok, lsp_config = pcall(require, "lspconfig")

if not (lsp_config_ok and cmp_nvim_lsp_status_ok and mason_ok and mason_config_ok) then
	print("LSPConfig, CMP_LSP, and/or Mason not installed!")
	return
end

-- Configure CMP
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

vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>fo", function(args)
	require("conform").format()
end, {})
vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_next()
end)
vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_prev()
end)

-- Map keys after LSP attaches (utility function)
local on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Debounce by 300ms by default
	client.config.flags.debounce_text_changes = 100
end

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

local capabilities = cmp_nvim_lsp.default_capabilities(normal_capabilities)

mason.setup({
	providers = {
		"mason.providers.client",
		"mason.providers.registry-api",
	},
})

mason_config.setup({
	ensure_installed = { "lua_ls", "angularls", "cssls", "html", "rust_analyzer" },
})

-- Configure linter
require("mason-nvim-lint").setup({
	ensure_installed = { "eslint_d", "prettierd" },
})

mason_config.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		local server = lsp_config[server_name]
		local server_status_ok, server_config = pcall(require, "lsp.servers." .. server.name)
		if not server_status_ok then
			-- print("The LSP '" .. server.name .. "' does not have a config.")
			server.setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		else
			server_config.setup(on_attach, capabilities, server)
		end
	end,
	-- Next, you can provide targeted overrides for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	["rust_analyzer"] = function()
		local rt_ok, rt = pcall(require, "rust-tools")

		local server = lsp_config["rust_analyzer"]
		server.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		return rt.setup({
			capabilities = capabilities,
			server = {
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					-- Hover actions
					vim.keymap.set("n", "<C-K>", rt.hover_actions.hover_actions, { buffer = bufnr })
					-- Code action groups
					vim.keymap.set("n", "<Leder>a", rt.code_action_group.code_action_group, { buffer = bufnr })
				end,
			},
		})
	end,
	-- for some reason angularls cannot be found in the servers folder and i am to lazy to find out why
	["angularls"] = function()
		local server = lsp_config["angularls"]
		server.setup({
			on_attach = on_attach,
			root_dir = lsp_config.util.root_pattern("angular.json", "project.json"),
			capabilities = capabilities,
		})
	end,
})

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
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
