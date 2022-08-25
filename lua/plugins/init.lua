-- Utility settings loader
local setup = function(mod, remote)
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
				local_config.setup()
			end
		end
	end
end

local no_setup = function(mod)
	local status = pcall(require, mod)
	if not status then
		print(mod .. " is not downloaded.")
		return
	else
		require(mod).setup({})
	end
end

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	print("Packer installed, please exit NVIM and re-open, then run :PackerInstall")
	return
end

local packer = require("packer")

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("onsails/lspkind-nvim")
	use("hrsh7th/nvim-cmp")
	use({ "hrsh7th/cmp-nvim-lua", ft = { "lua" } })
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("nvim-lua/plenary.nvim")
	use("rebelot/kanagawa.nvim") -- In colors.lua file
	use({ "stevearc/aerial.nvim", config = setup("plugins.aerial") })
	use({
		"L3MON4D3/LuaSnip",
		config = setup("plugins.luasnip"),
	})
	use({ "jose-elias-alvarez/null-ls.nvim", config = setup("plugins.null", "null-ls") })
	--	use({ "nvim-telescope/telescope-fzf-native.nvim", requires={ { "nvim-telescope/telescope.nvim" } }, run = "make" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = setup("plugins.telescope", "telescope"),
	})
	use("tpope/vim-dispatch")
	use("tpope/vim-repeat")
	use("tpope/vim-sleuth")
	use("tpope/vim-surround")
	use("tpope/vim-unimpaired")
	use({ "kevinhwang91/nvim-bqf", requires = "junegunn/fzf", config = setup("plugins.bqf", "bqf") })
	use({
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
		end,
	})
	use({ "rmagatti/auto-session", config = setup("plugins.auto-session") })
	use("ap/vim-buftabline")
	use("tpope/vim-eunuch")
	use("tpope/vim-obsession")
	use({ "mfussenegger/nvim-dap", config = setup("plugins.nvim-dap") })
	use("qpkorr/vim-bufkill")
	use({ "numToStr/Comment.nvim", config = no_setup("Comment") })
	use({ "samoshkin/vim-mergetool", before = require("plugins.mergetool") })
	use({ "numToStr/FTerm.nvim", config = setup("plugins.fterm", "FTerm") })
	use("romainl/vim-cool")
	use("tpope/vim-rhubarb")
	use("vim-scripts/BufOnly.vim")
	use("djoshea/vim-autoread")
	use("jtmkrueger/vim-c-cr")
	use({ "tpope/vim-fugitive", config = setup("plugins.fugitive") })
	use({ "windwp/nvim-autopairs", config = setup("plugins.autopairs", "nvim-autopairs") })
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = setup("plugins.lualine", "lualine"),
	})
	use({
		"alvarosevilla95/luatab.nvim",
		config = setup("plugins/luatab", "luatab"),
		requires = "kyazdani42/nvim-web-devicons",
	})
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = setup("plugins.gitsigns", "gitsigns"),
	})
	use({ "gelguy/wilder.nvim", config = setup("plugins.wilder", "wilder") })
	use({ "p00f/nvim-ts-rainbow", requires = "nvim-treesitter/nvim-treesitter" })
	use({ "kyazdani42/nvim-web-devicons", no_setup("nvim-web-devicons") })
	use({ "kyazdani42/nvim-tree.lua", config = setup("plugins.nvim_tree", "nvim-tree") })
	use({
		"sindrets/diffview.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = setup("plugins.diffview", "diffview"),
	})
	use({ "petertriho/nvim-scrollbar", config = setup("plugins.scrollbar", "scrollbar") })
	use({ "karb94/neoscroll.nvim", config = setup("plugins.neoscroll", "neoscroll") })
	use("itchyny/vim-gitbranch")
	use({ "harrisoncramer/jump-tag", config = setup("plugins.jump-tag", "jump-tag") })
	use({ "phaazon/hop.nvim", config = setup("plugins.hop", "hop") })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = setup("plugins.treesitter", "nvim-treesitter"),
	})
	use("lambdalisue/glyph-palette.vim")
	use("andymass/vim-matchup")
	use({ "mattn/emmet-vim", ft = { "html", "vue", "javascript", "javascriptreact", "typescriptreact" } })
	use("AndrewRadev/tagalong.vim")
	use("alvan/vim-closetag")
	use({ "vim-test/vim-test", config = setup("plugins.vim-test") })
	use('simrat38/rust-tools.nvim')
end)
