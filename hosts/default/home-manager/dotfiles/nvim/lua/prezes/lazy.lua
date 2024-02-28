-- This file can be loaded by calling `lua require('plugins')` from your init.vim

--[[
return require("lazy").setup({

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
			"L3MON4D3/LuaSnip", -- Required
		},
	},

	"lewis6991/gitsigns.nvim",
	"nvim-tree/nvim-web-devicons",
	"feline-nvim/feline.nvim",
	"nvim-neorg/neorg",
	"jose-elias-alvarez/null-ls.nvim",
	"nvim-tree/nvim-tree.lua",

	{
		"VonHeikemen/fine-cmdline.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},

	"lukas-reineke/indent-blankline.nvim",
})

--[[
    --use({
		"VonHeikemen/fine-cmdline.nvim",
		requires = {
			{ "MunifTanjim/nui.nvim" },
		},
	})



	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})


	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	})
    ]]
--
