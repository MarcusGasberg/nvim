local cmp_status_ok, cmp = pcall(require, "cmp")
local lspkind_status_ok, lspkind = pcall(require, "lspkind")
local luasnip_ok, luasnip = pcall(require, "luasnip")

if not (cmp_status_ok and luasnip_ok and lspkind_status_ok) then
	print("CMP dependencies not yet installed!")
	return
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Setup completion engine
if cmp_status_ok then
	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		formatting = {
			format = lspkind.cmp_format({
				with_text = false, -- do not show text alongside icons
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			}),
		},
		mapping = {
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-L>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-e>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				-- elseif has_words_before() then
				-- 	cmp.complete()
				else
					fallback()
				end
			end, { "i", "s", "c" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s", "c" }),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp", max_item_count = 10 },
			{ name = "nvim_lua", max_item_count = 10 },
			{ name = "luasnip", max_item_count = 10 },
		}),
	})
end
