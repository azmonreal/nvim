return {
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add          = { text = "│" },
				change       = { text = "│" },
				delete       = { text = "_" },
				topdelete    = { text = "‾" },
				changedelete = { text = "~" },
				untracked    = { text = "┆" },
			},

			on_attach = function (bufnr)
				local gs = package.loaded.gitsigns

				-- Navigation
				Utils.set_custom_maps({
					[""] = {
						{ "n", "]c", function ()
							if vim.wo.diff then return "]c" end
							vim.schedule(function () gs.next_hunk() end)
							return "<Ignore>"
						end, { expr = true } },

						{ "n", "[c", function ()
							if vim.wo.diff then return "[c" end
							vim.schedule(function () gs.prev_hunk() end)
							return "<Ignore>"
						end, { expr = true } },
						{ { "n" }, "<leader>gB", function () gs.blame_line { full = true } end, { desc = "Open telescope picker list" } },
					}
				})
			end
		}
	},
	{
		"kdheepak/lazygit.nvim",
		config = function ()
			vim.keymap.set({ "n" }, "<leader>gt", function () vim.cmd([[LazyGit]]) end, { desc = "" })
		end
	},
	{
		"tpope/vim-fugitive",

		config = function ()
			Utils.set_custom_maps({
				["<leader>g"] = {
					{ { "n" }, "g", "<cmd>Git<CR>",        { desc = "Git" } },
					{ { "n" }, "s", "<cmd>Git status<CR>", { desc = "Git status" } },
					{ { "n" }, "d", "<cmd>Git diff<CR>",   { desc = "Git diff" } },
					{ { "n" }, "l", "<cmd>Git log<CR>",    { desc = "Git log" } },
					{ { "n" }, "a", "<cmd>Git add<CR>",    { desc = "Git add" } },
					{ { "n" }, "b", "<cmd>Git branch<CR>", { desc = "Git branch" } },
					-- { { "n" }, "B", "<cmd>Git blame<CR>", { desc = "Open telescope picker list" } },
				}
			})
		end
	},
}
