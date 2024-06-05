return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine"
	},

	"Shatur/neovim-ayu",
	"shaunsingh/nord.nvim",
	"nyoom-engineering/oxocarbon.nvim",
	"scottmckendry/cyberdream.nvim",
}
