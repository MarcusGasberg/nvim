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
		lazy = false, priority = 1000, config = function()
			vim.cmd([[colorscheme catppuccin-mocha]])
		end
	},
	{ "rebelot/kanagawa.nvim" },
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
			"L3MON4D3/LuaSnip"
		},
	},
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim", build = ":MasonUpdate" },
	{ "williamboman/mason-lspconfig.nvim" },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = setup("plugins.null", "null-ls") 
  },
	{ "onsails/lspkind-nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "rafamadriz/friendly-snippets" },
	{ "L3MON4D3/LuaSnip", config = setup("plugins.luasnip") },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "jose-elias-alvarez/null-ls.nvim"},
	{ "jose-elias-alvarez/typescript.nvim"},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = setup("plugins.neo-tree", "neo-tree"),
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" } },
		config = setup("plugins.telescope", "telescope"),
	},
	-- {
	-- 	"nvim-telescope/telescope-file-browser.nvim",
	-- 	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	-- },
	{ "tpope/vim-repeat", event = "VeryLazy"},
	{ "tpope/vim-surround", event = "VeryLazy"},
	{ "tpope/vim-obsession", event = "VeryLazy"},
	{ "junegunn/fzf", },
	{
		"startup-nvim/startup.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = setup("plugins.startup"),
	},
	{
		"akinsho/bufferline.nvim",
		version = "v3.*",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = setup("plugins.bufferline", "bufferline"),
	},
	{ "windwp/nvim-autopairs", config = setup("plugins.autopairs", "nvim-autopairs") } ,
	{ "mfussenegger/nvim-dap", config = setup("plugins.nvim-dap"), event = "VeryLazy" },
	{ "qpkorr/vim-bufkill" },
	{ "numToStr/Comment.nvim", config = true, event = "VeryLazy"  },
	{ "akinsho/toggleterm.nvim", config = setup("plugins.toggleterm") },
	{ "romainl/vim-cool" },
	{ "vim-scripts/BufOnly.vim", event = "VeryLazy" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = setup("plugins.lualine", "lualine"),
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = setup("plugins.gitsigns", "gitsigns"),
	},
	{"nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" }},
	{ "kyazdani42/nvim-web-devicons", config = true },
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = setup("plugins.diffview", "diffview"),
	},
	{ "kevinhwang91/nvim-hlslens" },
	{
		"petertriho/nvim-scrollbar",
		dependencies =  { "kevinhwang91/nvim-hlslens" },
		config = setup("plugins.scrollbar", "scrollbar"),
	},
	{ "ggandor/leap.nvim", config = setup("plugins.leap", "leap") },
	{
		"nvim-treesitter/nvim-treesitter",
		config = setup("plugins.treesitter", "nvim-treesitter"),
	},
	{ "karb94/neoscroll.nvim", config = setup("plugins.neoscroll", "neoscroll") },
	{ "lambdalisue/glyph-palette.vim" },
	{ "vim-test/vim-test", config = setup("plugins.vim-test") },
	{ "simrat39/rust-tools.nvim" },
	{ "windwp/nvim-ts-autotag" },
	{"kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" }, config = setup("plugins.ufo", "ufo")},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = true
	}
})
