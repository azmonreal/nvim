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

	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

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
		config = function ()
			local ls = require("luasnip")

			Utils.setKeymaps({
				{
					{ mode = { "i" },      "<C-K>", function () ls.expand() end },
					{ mode = { "i", "s" }, "<C-L>", function () ls.jump(1) end },
					{ mode = { "i", "s" }, "<C-J>", function () ls.jump(-1) end },
					{ mode = { "i", "s" }, "<C-E>", function () if ls.choice_active() then ls.change_choice(1) end end }
				}
			}, { silent = true })

			ls.config.setup({
				store_selection_keys = "<C-K>",
				enable_autosnippets = true
			})


			local sn = ls.snippet_node
			local i = ls.insert_node

			Utils["luasnip"] = {
				get_visual =
					function (args, parent)
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

	{
		"lervag/vimtex",
		init = function ()
			vim.g.vimtex_view_method = "zathura"

			local augroup = vim.api.nvim_create_augroup("vimtex_config", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				pattern = "VimtexEventQuit",
				group = augroup,
				desc = "Clean files on exit.",
				command = [[ call vimtex#compiler#clean(0) ]],
			})
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
		config = function (_, opt)
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

	"andymass/vim-matchup",
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		ft = { "rust" },
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
		init = function ()
			local harpoon = require("harpoon")

			Utils.setKeymaps({
				{
					{ "<leader>a", function () harpoon:list():add() end },
					{ "<C-e>",     function () harpoon.ui:toggle_quick_menu(harpoon:list()) end },

					{ "<leader>1",     function () harpoon:list():select(1) end },
					{ "<leader>2",     function () harpoon:list():select(2) end },
					{ "<leader>3",     function () harpoon:list():select(3) end },
					{ "<leader>4",     function () harpoon:list():select(4) end },

					-- Toggle previous & next buffers> stored within Harpoon list
					{ "<leader>P", function () harpoon:list():prev({ --[[ui_nav_wrap = true ]] }) end },
					{ "<leader>N", function () harpoon:list():next({ --[[ui_nav_wrap = true]] }) end },
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

		config = function (_, opts)
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
		config = function (_, opts)
			local conform = require("conform")

			conform.setup(opts)

			vim.keymap.set({ "n", "v" }, "<leader>bf",
				function ()
					conform.format({ async = true, lsp_format = "fallback" }, function (err, did_edit)
						if err then
							vim.notify("Formatting error: " .. err, vim.log.levels.ERROR)
						else
							if did_edit then
								vim.notify("Formatted with Conform", vim.log.levels.INFO)
							else
								vim.notify("No formatting done", vim.log.levels.INFO)
							end
						end
					end)
				end,
				{ desc = "Run formatting, using LSP as fallback" })
		end
	},
	{
		"mfussenegger/nvim-lint",
		config = function ()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "mypy", }
			}

			vim.list_extend(lint.linters.mypy.args,
				{ "--strict", "--enable-incomplete-feature=NewGenericSyntax", function ()
					local cpath = vim.fn.expand("%:p:h")
					-- TODO: use better way to determine when inside onedrive
					if cpath:match("Semesters") then
						 -- TODO: use a local dir instead of having no cache
						return "--cache-dir=/dev/null"
					end
				end })

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function ()
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
		"brenoprata10/nvim-highlight-colors",
		enabled = false,
		opts = {
			render = "background", -- or 'foreground' or 'first_column'
			enable_named_colors = true,
			enable_tailwind = true,
		}
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {}
	},
	{
		"stevearc/aerial.nvim",
		opts = {
			layout = {
				min_width = 0.2,
				default_direction = "right",
			}
		},

		config = function (_, opts)
			require("aerial").setup(opts)

			vim.keymap.set("n", "<leader>n", function () vim.cmd [[AerialToggle]] end)
		end,

		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons"
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			delay = 500,
		},
		keys = {
			{
				"<leader>?",
				function ()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"Vigemus/iron.nvim",
		main = "iron.core",
		opts = function ()
			return {
				config = {
					-- Whether a repl should be discarded or not
					scratch_repl = true,
					-- Your repl definitions come here
					repl_definition = {
						sh = {
							-- Can be a table or a function that
							-- returns a table (see below)
							command = { "zsh" }
						},
						python = {
							command = { "ipython", "--no-autoindent" },
							format = require("iron.fts.common").bracketed_paste_python
						}
					},
					-- How the repl window will be displayed
					-- See below for more information
					repl_open_cmd = require("iron.view").split.vertical.botright(0.4)
				},
				-- Iron doesn't set keymaps by default anymore.
				-- You can set them here or manually add keymaps to the functions in iron.core
				keymaps = {
					send_motion = "<space>sc",
					visual_send = "<space>sc",
					send_file = "<space>sf",
					send_line = "<space>sl",
					send_paragraph = "<space>sp",
					send_until_cursor = "<space>su",
					send_mark = "<space>sm",
					mark_motion = "<space>mc",
					mark_visual = "<space>mc",
					remove_mark = "<space>md",
					cr = "<space>s<cr>",
					interrupt = "<space>s<space>",
					exit = "<space>sq",
					clear = "<space>cl",
				},
				-- If the highlight is on, you can change how it looks
				-- For the available options, check nvim_set_hl
				highlight = {
					italic = true
				},
				ignore_blank_lines = true, -- ignore blank lines when sending visual select lines

			}
		end,
		init = function ()
			Utils.setKeymaps({
				["<leader>r"] = {
					{ "s", "<cmd>IronRepl<cr>",    { desc = "Toggle Iron REPL" } },
					{ "r", "<cmd>IronRestart<cr>", { desc = "Restart Iron REPL" } },
					{ "f", "<cmd>IronFocus<cr>",   { desc = "Focus Iron REPL" } },
					{ "h", "<cmd>IronHide<cr>",    { desc = "Hide Iron REPL" } },
				}
			})
		end
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"folke/trouble.nvim",
		dependencies = {
			{
				"folke/todo-comments.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
				event = { "BufReadPost" },
				opts = true,
				init = function ()
					Utils.setKeymaps({
						{
							{ "]t", function () require("todo-comments").jump_next() end, { desc = "Next todo comment" } },
							{ "[t", function () require("todo-comments").jump_prev() end, { desc = "Previous todo comment" } },
						}
					})
				end
			},
		},
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		init = function ()
			Utils.setKeymaps({
				["<leader>x"] = {
					{ "x", "<cmd>Trouble diagnostics toggle<cr>",                        { desc = "Diagnostics (Trouble)", } },
					{ "X", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           { desc = "Buffer Diagnostics (Trouble)", } },
					{ "s", "<cmd>Trouble symbols toggle focus=false<cr>",                { desc = "Symbols (Trouble)", } },
					{ "l", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)", } },
					{ "L", "<cmd>Trouble loclist toggle<cr>",                            { desc = "Location List (Trouble)", } },
					{ "Q", "<cmd>Trouble qflist toggle<cr>",                             { desc = "Quickfix List (Trouble)", } },
					{ "t", "<cmd>Trouble todo<cr>",                                      { desc = "Quickfix List (Trouble)", } },
				}
			})
		end
	},

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod",                     lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function ()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
}
