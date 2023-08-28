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

local plugins = {
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

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	"lewis6991/gitsigns.nvim",
	"kdheepak/lazygit.nvim",
	"sindrets/diffview.nvim",

	"lervag/vimtex",
	"ahmedkhalf/project.nvim",
}
local lazy_opts = {}

require("lazy").setup(plugins, lazy_opts)
