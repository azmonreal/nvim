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
				local gitsigns = require("gitsigns")
				Utils.setKeymaps({
					{
						-- Navigation
						{ "]c", function ()
							if vim.wo.diff then
								vim.cmd.normal({ "]c", bang = true })
							else
								gitsigns.nav_hunk("next")
							end
						end },
						{ "[c", function ()
							if vim.wo.diff then
								vim.cmd.normal({ "[c", bang = true })
							else
								gitsigns.nav_hunk("prev")
							end
						end },
						-- Toggles
						{ "<leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" } },
						{ "<leader>gtw", gitsigns.toggle_word_diff,          { desc = "Toggle word diff" } },
						-- Text object
						{ "ih",          gitsigns.select_hunk,               { desc = "Select hunk" },              mode = { "o", "x" } },
					},
					["<leader>h"] = {
						-- Actions
						{ "s", gitsigns.stage_hunk,                                                         { desc = "Stage hunk" } },
						{ "r", gitsigns.reset_hunk,                                                         { desc = "Reset hunk" } },
						{ "s", function () gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk (visual)" }, mode = "v" },
						{ "r", function () gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk (visual)" }, mode = "v" },
						{ "S", gitsigns.stage_buffer,                                                       { desc = "Stage buffer" } },
						{ "R", gitsigns.reset_buffer,                                                       { desc = "Reset buffer" } },
						{ "p", gitsigns.preview_hunk,                                                       { desc = "Preview hunk" } },
						{ "i", gitsigns.preview_hunk_inline,                                                { desc = "Preview hunk inline" } },
						{ "b", function () gitsigns.blame_line({ full = true }) end,                        { desc = "Blame line" } },
						{ "d", gitsigns.diffthis,                                                           { desc = "Diff this" } },
						{ "D", function () gitsigns.diffthis("~") end,                                      { desc = "Diff this ~" } },
						{ "Q", function () gitsigns.setqflist("all") end,                                   { desc = "Set qflist (all)" } },
						{ "q", gitsigns.setqflist, { desc = "Set qflist" },
						},
					},
				})
			end,
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		init = function ()
			Utils.setKeymaps({
				["<leader>g"] = {
					{ "g", "<cmd>Neogit<CR>",        { desc = "Git" } },
					{ "d", "<cmd>Neogit diff<CR>",   { desc = "Git diff" } },
					{ "l", "<cmd>Neogit log<CR>",    { desc = "Git log" } },
					{ "b", "<cmd>Neogit branch<CR>", { desc = "Git branch" } },
				},
			})
		end,
		---@module "neogit"
		---@type NeogitConfig
		opts = {
			graph_style = "kitty",
		},
	},
	{
		"sindrets/diffview.nvim",
	},
	{
		"isakbm/gitgraph.nvim",
		opts = {
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%H:%M:%S %d-%m-%Y",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				on_select_commit = function (commit)
					print("selected commit:", commit.hash)
				end,
				on_select_range_commit = function (from, to)
					print("selected range:", from.hash, to.hash)
				end,
			},
		},
		keys = {
			{
				"<leader>gL",
				function ()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "GitGraph - Draw",
			},
		},
	},

}
