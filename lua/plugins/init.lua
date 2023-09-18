return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	"shaunsingh/nord.nvim",

	-- {
	-- "folke/noice.nvim",
	-- dependencies = {
	-- -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- "MunifTanjim/nui.nvim",
	-- -- OPTIONAL:
	-- --   `nvim-notify` is only needed, if you want to use the notification view.
	-- --   If not available, we use `mini` as the fallback
	-- "rcarriga/nvim-notify",
	-- }
	-- },

	"folke/neodev.nvim",

	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig",
	"neovim/nvim-lspconfig",

	"nvim-treesitter/nvim-treesitter",

	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",

	"hrsh7th/nvim-cmp",

	"zbirenbaum/copilot.lua",

	"L3MON4D3/LuaSnip",

	--telescope,

	"lewis6991/gitsigns.nvim",
	"kdheepak/lazygit.nvim",
	"sindrets/diffview.nvim",

	"lervag/vimtex",
	"ahmedkhalf/project.nvim",

	"nvim-lua/plenary.nvim",
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"monkoose/nvlime",
		dependencies = { "monkoose/parsley" }
	},

	"Shatur/neovim-cmake",
}
