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

	{
		"nvim-treesitter/nvim-treesitter",
		main = "nvim-treesitter.configs",
		opts = {
			highlight = {
				enable = true,
				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
				disable = { "latex" },
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gnn", -- set to `false` to disable one of the mappings
					node_incremental = "grn",
					scope_incremental = "grc",
					node_decremental = "grm",
				},
			},
		}
	},

	{
		"zbirenbaum/copilot.lua",
		config = true,
	},

	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")

			Utils.set_custom_maps({
				[""] = {
					{ { "i" },      "<C-K>", function() ls.expand() end, { silent = true } },
					{ { "i", "s" }, "<C-L>", function() ls.jump(1) end,  { silent = true } },
					{ { "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true } },

					{ { "i",        "s" }, "<C-E>", function()
						if ls.choice_active() then
							ls.change_choice(1)
						end
					end, { silent = true }
					}
				}
			})
		end

	},

	"sindrets/diffview.nvim",

	{
		"lervag/vimtex",
		config = function()
			vim.g.vimtex_view_method = "zathura"
		end
	},

	{
		"ahmedkhalf/project.nvim",
		main = "project_nvim",
		opts = {
			manual_mode = false,
			detection_methods = { "lsp", "pattern", },
			patterns = { ".git", "Makefile", "package.json", "CMakeLists.txt" },
			ignore_lsp = { "lua_ls" },
			exclude_dirs = {},
			show_hidden = false,
			silent_chdir = true,
			scope_chdir = "global", -- "global" | "tab" | "win"
			datapath = vim.fn.stdpath("data"),
		}
	},

	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",

	{
		"monkoose/nvlime",
		dependencies = { "monkoose/parsley" }
	},

	{
		"Shatur/neovim-cmake",
		config = true,
	},
	--"Civitasv/cmake-tools.nvim",

	"christoomey/vim-tmux-navigator",

	{
		"mrcjkb/rustaceanvim",
		version = "^3",
		ft = { "rust" },
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})
		end,
		init = function()
			local harpoon = require("harpoon")

			Utils.set_custom_maps({
				[""] =
				{
					{ "n", "<leader>a", function() harpoon:list():append() end },
					{ "n", "<C-e>",     function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },

					{ "n", "<M-h>",     function() harpoon:list():select(1) end },
					{ "n", "<M-j>",     function() harpoon:list():select(2) end },
					{ "n", "<M-k>",     function() harpoon:list():select(3) end },
					{ "n", "<M-l>",     function() harpoon:list():select(4) end },

					-- Toggle previous & next buffers> stored within Harpoon list
					{ "n", "<leader>P", function() harpoon:list():prev({ --[[ui_nav_wrap = true ]] }) end },
					{ "n", "<leader>N", function() harpoon:list():next({ --[[ui_nav_wrap = true]] }) end },
				}
			})
		end
	},

	{
		"j-hui/fidget.nvim",
		opts = {}
	},
}
