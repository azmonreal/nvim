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
				Utils.setKeymaps({
					{
						{ "]c", function ()
							if vim.wo.diff then return "]c" end
							vim.schedule(function () gs.next_hunk() end)
							return "<Ignore>"
						end, { expr = true } },
						{ "[c", function ()
							if vim.wo.diff then return "[c" end
							vim.schedule(function () gs.prev_hunk() end)
							return "<Ignore>"
						end, { expr = true } },
						{ "<leader>gB", function () gs.blame_line { full = true } end, { desc = "Git blame" } },
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
			"nvim-telescope/telescope.nvim",
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
}
