vim.g.mapleader = " "
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.fn.setenv("CARGO_TARGET_DIR", "/home/prezes/.rust-analyzer-target")

if vim.g.vscode then
	-- VSCode extension
	return
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
require("lazy").setup({

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

	"catppuccin/nvim",
	"nvim-treesitter/nvim-treesitter",
	"ThePrimeagen/harpoon",
	"mbbill/undotree",
	"tpope/vim-fugitive",

	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			"neovim/nvim-lspconfig", -- Required
			"williamboman/mason.nvim", -- Optional
			"williamboman/mason-lspconfig.nvim", -- Optional
			"hrsh7th/nvim-cmp", -- Required
			"hrsh7th/cmp-nvim-lsp", -- Required
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"L3MON4D3/LuaSnip", -- Required
			"rafamadriz/friendly-snippets", -- Required
		},
	},

	"lewis6991/gitsigns.nvim",
	"nvim-tree/nvim-web-devicons",
	"feline-nvim/feline.nvim",
	"nvim-neorg/neorg",
	--"jose-elias-alvarez/null-ls.nvim",
	"nvimtools/none-ls.nvim",
	"nvim-tree/nvim-tree.lua",
	"slint-ui/vim-slint",

	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},

	"lukas-reineke/indent-blankline.nvim",
	{
		"saecki/crates.nvim",
		tag = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
		{
			"kristijanhusak/vim-dadbod-ui",
			dependencies = {
				{ "tpope/vim-dadbod", lazy = true },
				{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
			},
			cmd = {
				"DBUI",
				"DBUIToggle",
				"DBUIAddConnection",
				"DBUIFindBuffer",
			},
			init = function()
				-- Your DBUI configuration
				vim.g.db_ui_use_nerd_fonts = 1
			end,
		},
	},
	{ "lervag/vimtex", lazy = false },
	{
		"chipsenkbeil/distant.nvim",
		branch = "v0.3",
		config = function()
			require("distant"):setup()
		end,
		{
			"smoka7/multicursors.nvim",
			event = "VeryLazy",
			dependencies = {
				"smoka7/hydra.nvim",
			},
			opts = {},
			cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
			keys = {
				{
					mode = { "v", "n" },
					"<Leader>m",
					"<cmd>MCstart<cr>",
					desc = "Create a selection for selected text or word under the cursor",
				},
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},
})
require("prezes")
