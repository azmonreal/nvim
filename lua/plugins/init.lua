return {
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
		build = "TSUpdate",
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

			ls.config.setup({
				store_selection_keys = "<C-K>",
				enable_autosnippets = true
			})


			local sn = ls.snippet_node
			local i = ls.insert_node

			Utils["luasnip"] = {
				get_visual =
					function(args, parent)
						if (#parent.snippet.env.LS_SELECT_RAW > 0) then
							return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
						else -- If LS_SELECT_RAW is empty, return a blank insert node
							return sn(nil, i(1))
						end
					end
			}

			require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets/" })
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
		},
		config = function(_, opt)
			require("project_nvim").setup(opt)

			vim.keymap.set({ "n" }, "<leader>cd", require("project_nvim.project").on_buf_enter, { desc = "" })
		end
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

	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		ft = { "rust" },
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		init = function()
			local harpoon = require("harpoon")

			Utils.set_custom_maps({
				[""] =
				{
					{ "n", "<leader>a", function() harpoon:list():add() end },
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
	{
		"stevearc/oil.nvim",
		opts = {
			keymaps = {
				["q"] = "actions.close"
			}
		},

		config = function(_, opts)
			require("oil").setup(opts)

			vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open file explorer" })
			vim.keymap.set("n", "<leader>-", "<cmd>Oil --float<CR>", { desc = "Open file explorer in float" })
		end,

		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },

	},
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = nil,
			quiet = true,
			formatters_by_ft = {
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				markdown = { "prettier" },
				yaml = { "prettier" },
			},
		},
		config = function(_, opts)
			local conform = require("conform")

			conform.setup(opts)

			vim.keymap.set({"n", "v"}, "<leader>bf", function() conform.format({ async = true, lsp_format = "fallback" }) end, { desc = "Run formatting, using LSP as fallback" })
		end
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "mypy", }
			}

			vim.list_extend(lint.linters.mypy.args , { "--strict", })

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					require("lint").try_lint()

					-- You can call `try_lint` with a linter name or a list of names to always
					-- run specific linters, independent of the `linters_by_ft` configuration
					-- require("lint").try_lint("cspell")
				end,
			})
		end
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false -- Auto close on trailing </
			},
			-- Also override individual filetype configs, these take priority.
			-- Empty by default, useful if one of the "opts" global settings
			-- doesn't work well in a specific filetype
			per_filetype = {
				["html"] = {
					enable_close = false
				}
			}
		}
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {}
	},
}
