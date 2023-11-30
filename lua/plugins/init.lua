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

	{
		"numToStr/Comment.nvim",
		lazy = false
	},

	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc, " " },                                  click = "v:lua.ScFa" },
							{
								sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true, },
								click = "v:lua.ScSa"
							},
							{ text = { builtin.lnumfunc, " " },                                  click = "v:lua.ScLa" },
							{ sign = { namespace = { "gitsign*" }, maxwidth = 1, auto = false }, click = "v:lua.ScSa" },
							{ sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true },     click = "v:lua.ScSa" },
						},
					})
				end,
			},
		},
		event = "BufReadPost",
		opts = {
			open_fold_hl_timeout = 300,
			provider_selector = function(a)
				return "lsp"
			end,
		},

		init = function()
			vim.keymap.set("n", "zR", function()
				require("ufo").openAllFolds()
			end)
			vim.keymap.set("n", "zM", function()
				require("ufo").closeAllFolds()
			end)
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			require("dapui").setup()
			local dap = require("dap")
			dap.adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-vscode", -- adjust as needed, must be absolute path
				name = "lldb"
			}
			local dap = require("dap")
			dap.configurations.cpp = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
					args = {},

					-- 💀
					-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
					--
					--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
					--
					-- Otherwise you might get the following error:
					--
					--    Error on launch: Failed to attach to the target process
					--
					-- But you should be aware of the implications:
					-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
					-- runInTerminal = false,
				},
			}
		end,

	},

	{
		"mrcjkb/rustaceanvim",
		version = "^3",
		ft = { "rust" },
	},
}
