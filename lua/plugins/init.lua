-- Utility settings loader
local setup = function(mod, remote)
	return function()
		if remote == nil then
			-- If plugin does not need "require" setup, then just set it up.
			require(mod)
		else
			local status = pcall(require, remote)
			if not status then
				print(remote .. " is not downloaded.")
				return
			else
				local local_config = require(mod)
				if type(local_config) == "table" then
					return local_config.setup()
				end
			end
		end
	end
end

local fn = vim.fn
local lazypath = fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

lazy.setup({
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = false, -- disables setting the background color.
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					gitsigns = true,
					treesitter = true,
					dashboard = true,
					indent_blankline = {
						enabled = true,
						colored_indent_levels = false,
					},
					leap = true,
					mason = true,
					neotest = true,
					dap = true,
					harpoon = true,
				},
			})
			vim.cmd([[colorscheme catppuccin-mocha]])
		end,
		cond = not vim.g.vscode,
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{ "rebelot/kanagawa.nvim", cond = not vim.g.vscode },
	{
		"hrsh7th/nvim-cmp",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"onsails/lspkind-nvim",
			"L3MON4D3/LuaSnip",
		},
		cond = not vim.g.vscode,
	},
	{ "neovim/nvim-lspconfig", cond = not vim.g.vscode },
	{ "williamboman/mason.nvim", build = ":MasonUpdate", cond = not vim.g.vscode },
	{ "williamboman/mason-lspconfig.nvim", cond = not vim.g.vscode },
	{ "rshkarin/mason-nvim-lint", cond = not vim.g.vscode },
	{ "onsails/lspkind-nvim", cond = not vim.g.vscode },
	{ "nvim-lua/plenary.nvim", cond = not vim.g.vscode },
	{ "rafamadriz/friendly-snippets", cond = not vim.g.vscode },
	{ "tpope/vim-abolish" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-dispatch" },
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = setup("plugins.luasnip"),
		cond = not vim.g.vscode,
	},
	{ "saadparwaiz1/cmp_luasnip", cond = not vim.g.vscode },
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = setup("plugins.typescript-tools", "typescript-tools"),
		cond = not vim.g.vscode,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = setup("plugins.oil", "oil"),
		cond = not vim.g.vscode,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = setup("plugins.telescope", "telescope"),
		cond = not vim.g.vscode,
	},
	{ "junegunn/fzf", cond = not vim.g.vscode },
	{ "mfussenegger/nvim-dap", config = setup("plugins.nvim-dap"), cond = not vim.g.vscode },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = setup("plugins.dap-ui"),
		cond = not vim.g.vscode,
	},
	{ "akinsho/toggleterm.nvim", config = setup("plugins.toggleterm"), cond = not vim.g.vscode },
	{ "romainl/vim-cool" },
	{ "vim-scripts/BufOnly.vim", event = "VeryLazy", cond = not vim.g.vscode },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = setup("plugins.lualine", "lualine"),
		cond = not vim.g.vscode,
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = setup("plugins.gitsigns", "gitsigns"),
		cond = not vim.g.vscode,
	},
	{
		"tpope/vim-fugitive",
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = setup("plugins.diffview", "diffview"),
		cond = not vim.g.vscode,
	},
	{ "kevinhwang91/nvim-hlslens", config = true },
	{
		"petertriho/nvim-scrollbar",
		dependencies = { "kevinhwang91/nvim-hlslens" },
		config = setup("plugins.scrollbar", "scrollbar"),
		cond = not vim.g.vscode,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = setup("plugins.treesitter", "nvim-treesitter"),
	},
	{ "lambdalisue/glyph-palette.vim", cond = not vim.g.vscode },
	{ "simrat39/rust-tools.nvim", cond = not vim.g.vscode },
	{ "windwp/nvim-ts-autotag", cond = not vim.g.vscode },
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = true,
		cond = not vim.g.vscode,
	},
	{ "folke/neodev.nvim", opts = {}, cond = not vim.g.vscode },
	{ "norcalli/nvim-colorizer.lua", config = true, cond = not vim.g.vscode },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = setup("plugins.indent-blankline"),
		cond = not vim.g.vscode,
	},
	{ "vim-test/vim-test", config = setup("plugins.vim-test"), cond = not vim.g.vscode },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"haydenmeade/neotest-jest",
			"nvim-neotest/neotest-vim-test",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = setup("plugins.neotest"),
		cond = not vim.g.vscode,
	},
	{ "github/copilot.vim", cond = not vim.g.vscode },
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		cond = not vim.g.vscode,
	},
	{
		"mfussenegger/nvim-lint",
		config = setup("plugins.lint", "lint"),
		cond = not vim.g.vscode,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"stevearc/conform.nvim",
		config = setup("plugins.conform", "conform"),
		cond = not vim.g.vscode,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = setup("plugins.surround"),
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = setup("plugins.comment", "Comment"),
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{ "echasnovski/mini.nvim", version = "*", config = setup("plugins.mini") },
	{
		"norcalli/nvim-colorizer.lua",
		config = setup("plugins.colorizer"),
		cond = not vim.g.vscode,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = setup("plugins.harpoon"),
		cond = not vim.g.vscode,
	},
})
