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
		---@module "lazydev"
		---@type lazydev.Config
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
		build = ":TSUpdate",
		config = function ()
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
				callback = function (ev)
					local ok = pcall(vim.treesitter.start, ev.buf)

					if ok then
						vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
						vim.wo[0][0].foldmethod = "expr"

						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		---@module "treesitter-context"
		---@type TSContext.Config
		opts = {
			enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
			multiwindow = false, -- Enable multiwindow support.
			max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		},
	},

	{
		"zbirenbaum/copilot.lua",
		opts = {
			filetypes = {
				yaml = true,
			},
		},
	},

	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
		init = function ()
			local ls = require("luasnip")

			Utils.setKeymaps({
				{
					{ mode = { "i" },      "<C-K>", function () ls.expand() end },
					{ mode = { "i", "s" }, "<C-L>", function () ls.jump(1) end },
					{ mode = { "i", "s" }, "<C-J>", function () ls.jump(-1) end },
					{ mode = { "i", "s" }, "<C-E>", function () if ls.choice_active() then ls.change_choice(1) end end },
				},
			}, { silent = true })

			ls.config.setup({
				store_selection_keys = "<C-K>",
				enable_autosnippets = true,
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
					end,
			}

			require("luasnip.loaders.from_lua").load({ paths = "./lua/snippets/" })
		end,
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
		end,
	},

	{
		-- TODO: check behavior is as expected from previous version
		"DrKJeff16/project.nvim",
		opts = {},
	},

	"nvim-tree/nvim-web-devicons",

	{
		"monkoose/nvlime",
		dependencies = { "monkoose/parsley" },
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
		-- ft = { "rust" },
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		init = function ()
			Utils.setKeymaps(
				{
					{
						{ "<F8>",  "<cmd>RustLsp debuggables<CR>" },
						{ "<F20>", ":RustLsp debuggables" },
					},
				}
			)

			vim.g.rustaceanvim = {
				server = {
					on_attach = function (client, bufnr)
						-- you can also put keymaps in here
					end,
					settings = {
						-- rust-analyzer language server configuration
						["rust-analyzer"] = {
							runnables = {
								extraArgs = {
									"--release",
								},
							},
						},
					},
				},
			}
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		init = function ()
			local harpoon = require("harpoon")

			Utils.setKeymaps({
				{
					{ "<leader>a", function () harpoon:list():add() end },
					{ "<C-e>",     function () harpoon.ui:toggle_quick_menu(harpoon:list()) end },

					{ "<leader>1", function () harpoon:list():select(1) end },
					{ "<leader>2", function () harpoon:list():select(2) end },
					{ "<leader>3", function () harpoon:list():select(3) end },
					{ "<leader>4", function () harpoon:list():select(4) end },

					-- Toggle previous & next buffers> stored within Harpoon list
					{ "<leader>P", function () harpoon:list():prev({ --[[ui_nav_wrap = true ]] }) end },
					{ "<leader>N", function () harpoon:list():next({ --[[ui_nav_wrap = true]] }) end },
				},
			})
		end,
	},

	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"stevearc/oil.nvim",
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		---@module "oil"
		---@type oil.SetupOpts
		opts = {
			keymaps = {
				["q"] = "actions.close",
			},
		},

		init = function ()
			vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open file explorer" })
			vim.keymap.set("n", "<leader>-", "<cmd>Oil --float<CR>", { desc = "Open file explorer in float" })
		end,
	},
	{
		"stevearc/conform.nvim",
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
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
		init = function ()
			local conform = require("conform")

			vim.keymap.set({ "n", "v" }, "<leader>bf",
				function ()
					conform.format({ async = true, lsp_format = "fallback" }, function (err, did_edit)
						if err then
							if err == "No result returned from LSP formatter" then
								vim.notify(err, vim.log.levels.INFO)
							else
								vim.notify("Formatting error: " .. err, vim.log.levels.ERROR)
							end
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
		end,
	},
	{
		"mfussenegger/nvim-lint",
		config = function ()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "mypy" },
			}

			vim.list_extend(lint.linters.mypy.args,
				{ "--strict", "--enable-incomplete-feature=NewGenericSyntax", function ()
					-- local cpath = vim.fn.expand("%:p:h")
					-- TODO: use better way to determine when inside onedrive
					-- if cpath:match("Semesters") then
					-- TODO: use a local dir instead of having no cache
					-- 	return "--cache-dir=/dev/null"
					-- end
				end })

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function ()
					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					require("lint").try_lint(nil, { ignore_errors = true })

					-- You can call `try_lint` with a linter name or a list of names to always
					-- run specific linters, independent of the `linters_by_ft` configuration
					-- require("lint").try_lint("cspell")
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		---@module "nvim-ts-autotag"
		---@type nvim-ts-autotag.PluginSetup
		opts = {
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false, -- Auto close on trailing </
			},
			-- Also override individual filetype configs, these take priority.
			-- Empty by default, useful if one of the "opts" global settings
			-- doesn't work well in a specific filetype
			per_filetype = {
				["html"] = {
					enable_close = false,
				},
			},
		},
	},
	{
		"brenoprata10/nvim-highlight-colors",
		enabled = false,
		opts = {
			render = "background", -- or 'foreground' or 'first_column'
			enable_named_colors = true,
			enable_tailwind = true,
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		---@module "which-key"
		---@type wk.Opts
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
							command = { "zsh" },
						},
						python = {
							command = { "ipython", "--no-autoindent" },
							format = require("iron.fts.common").bracketed_paste_python,
							block_dividers = { "# %%", "#%%" },
							env = { PYTHON_BASIC_REPL = "1" }, --this is needed for python3.13 and up.
						},
					},
					-- set the file type of the newly created repl to ft
					-- bufnr is the buffer id of the REPL and ft is the filetype of the
					-- language being used for the REPL.
					repl_filetype = function (bufnr, ft)
						return ft
						-- or return a string name such as the following
						-- return "iron"
					end,
					-- How the repl window will be displayed
					-- See below for more information
					-- repl_open_cmd = require("iron.view").split.vertical.botright(0.4),
					repl_open_cmd = require("iron.view").right(0.4),
				},
				-- Iron doesn't set keymaps by default anymore.
				-- You can set them here or manually add keymaps to the functions in iron.core
				keymaps = {
					toggle_repl = "<space>rt", -- toggles the repl open and closed.
					-- If repl_open_command is a table as above, then the following keymaps are
					-- available
					-- toggle_repl_with_cmd_1 = "<space>rv",
					-- toggle_repl_with_cmd_2 = "<space>rh",
					restart_repl = "<space>rr", -- calls `IronRestart` to restart the repl
					send_motion = "<space>sc",
					visual_send = "<space>sc",
					send_file = "<space>sf",
					send_line = "<space>sl",
					send_paragraph = "<space>sp",
					send_until_cursor = "<space>su",
					send_mark = "<space>sm",
					send_code_block = "<space>sb",
					send_code_block_and_move = "<space>sn",
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
					italic = true,
				},
				ignore_blank_lines = true, -- ignore blank lines when sending visual select lines

			}
		end,
		init = function ()
			Utils.setKeymaps({
				["<leader>r"] = {
					{ "f", "<cmd>IronFocus<cr>", { desc = "Focus Iron REPL" } },
					{ "h", "<cmd>IronHide<cr>",  { desc = "Hide Iron REPL" } },
				},
			})
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = {
			{
				"folke/todo-comments.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
				event = { "BufReadPost" },
				opts = true,
			},
		},
		---@module "trouble"
		---@type trouble.Config
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		init = function ()
			local trouble = require("trouble")
			Utils.setKeymaps({
				{
					-- FIX: view doesnt update properly when jumping from another window (it may be already fixed?)
					{ "]x", function ()
						if trouble.is_open() then
							trouble.next()
							trouble.jump()
						else
							vim.notify("No trouble view open", vim.log.levels.INFO)
						end
					end, { desc = "Select next trouble item" } },
					{ "[x", function ()
						if trouble.is_open() then
							trouble.prev()
							trouble.jump()
						else
							vim.notify("No trouble view open", vim.log.levels.INFO)
						end
					end, { desc = "Select previous trouble item" } },
				},
				["<leader>x"] = {
					{ "x", "<cmd>Trouble diagnostics toggle<cr>",                        { desc = "Diagnostics (Trouble)" } },
					{ "X", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           { desc = "Buffer Diagnostics (Trouble)" } },
					{ "s", "<cmd>Trouble symbols toggle focus=false win={size=0.2}<cr>", { desc = "Symbols (Trouble)" } },
					{ "l", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" } },
					{ "L", "<cmd>Trouble loclist toggle<cr>",                            { desc = "Location List (Trouble)" } },
					{ "Q", "<cmd>Trouble qflist toggle<cr>",                             { desc = "Quickfix List (Trouble)" } },
					{ "t", "<cmd>Trouble todo<cr>",                                      { desc = "Quickfix List (Trouble)" } },
				},
			})
		end,
	},
	{
		"jinh0/eyeliner.nvim",
		config = function ()
			require "eyeliner".setup {
				-- show highlights only after keypress
				highlight_on_key = true,

				-- dim all other characters if set to true (recommended!)
				dim = false,

				-- set the maximum number of characters eyeliner.nvim will check from
				-- your current cursor position; this is useful if you are dealing with
				-- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
				max_length = 9999,

				-- filetypes for which eyeliner should be disabled;
				-- e.g., to disable on help files:
				-- disabled_filetypes = {"help"}
				disabled_filetypes = {},

				-- buftypes for which eyeliner should be disabled
				-- e.g., disabled_buftypes = {"nofile"}
				disabled_buftypes = {},

				-- add eyeliner to f/F/t/T keymaps;
				-- see section on advanced configuration for more information
				default_keymaps = true,
			}
		end,
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
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- use latest release, remove to use latest commit
		opts = function ()
			local workspaces = {}
			for name, type in vim.fs.dir("~/Documents/vaults") do
				if type == "directory" or type == "link" then
					table.insert(workspaces, {
						name = name,
						path = "~/Documents/vaults/" .. name,
					})
				end
			end

			---@module 'obsidian'
			---@type obsidian.config
			local opts = {
				legacy_commands = false, -- this will be removed in the next major release
				-- merge generated with manual
				workspaces = vim.list_extend(workspaces, {}),
				callbacks = {
					enter_note = function (note)
						vim.keymap.set("n", "<leader>fo", "<cmd>Obsidian<cr>", {
							buffer = true,
							desc = "Obsidian menu",
						})
					end,
				},
			}
			return opts
		end,
	},
}
