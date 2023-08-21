vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.laststatus = 3
vim.opt.winbar = "%f"

vim.g.mapleader = " "

vim.keymap.set({ "n" }, "<C-_>", "<cmd>noh<CR>", { desc = "Stop highlighting search pattern" })

vim.keymap.set({ "n" }, "<Tab>", "<cmd>bn<CR>", { desc = "Switch to next buffer" })
vim.keymap.set({ "n" }, "<S-Tab>", "<cmd>bp<CR>", { desc = "Switch to previous buffer" })

vim.keymap.set({ "n" }, "<M-k>", "<C-w>k", { desc = "Move cursor to window below current one" })
vim.keymap.set({ "n" }, "<M-j>", "<C-w>j", { desc = "Move cursor to window above current one" })
vim.keymap.set({ "n" }, "<M-h>", "<C-w>h", { desc = "Move cursor to window left of current one" })
vim.keymap.set({ "n" }, "<M-l>", "<C-w>l", { desc = "Move cursor to window right of current one" })

vim.keymap.set({ "n" }, "<leader>bf", vim.lsp.buf.format, { desc = "Run lsp format command on current buffer" })

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
	"folke/tokyonight.nvim",

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

	"L3MON4D3/LuaSnip",

	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	"lewis6991/gitsigns.nvim",
	"kdheepak/lazygit.nvim",
}
local lazy_opts = {}

require("lazy").setup(plugins, lazy_opts)
vim.cmd [[colorscheme tokyonight-night]]

require("mason").setup()
require("mason-lspconfig").setup()

require("neodev").setup()

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

require("lspconfig").lua_ls.setup {
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
			},
		},
	},
}
require("lspconfig").texlab.setup {
	capabilities = capabilities
}

local cmp = require("cmp")

local cmp_setup = {
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
	}, {
		{ name = 'buffer' },
	}),
}

cmp.setup(cmp_setup)

require('gitsigns').setup {
	signs = {
		add          = { text = '│' },
		change       = { text = '│' },
		delete       = { text = '_' },
		topdelete    = { text = '‾' },
		changedelete = { text = '~' },
		untracked    = { text = '┆' },
	},

	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map('n', ']c', function()
			if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		map('n', '[c', function()
			if vim.wo.diff then return '[c' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, { expr = true })
	end
}
