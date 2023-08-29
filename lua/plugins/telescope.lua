return {
	"nvim-telescope/telescope.nvim",

	dependencies =
	{
		"nvim-lua/plenary.nvim",
		"jvgrootveld/telescope-zoxide",
		"benfowler/telescope-luasnip.nvim",
		"paopaol/telescope-git-diffs.nvim",
		"tsakirist/telescope-lazy.nvim",
	},

	config = function(_, opts)
		opts.defaults.file_sorter = require("telescope.sorters").get_fuzzy_file
		opts.defaults.generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter

		require("telescope").setup(opts)

		local telescope_extensions = {
			"projects",
			"zoxide",
			"luasnip",
			"git_diffs",
			"lazy",
		}

		for _, e in pairs(telescope_extensions) do
			require("telescope").load_extension(e)
		end
	end,

	opts = {
		defaults = {
			sorting_strategy = "ascending",
			layout_config = {
				prompt_position = "top",
			},
			path_display = "smart",

		},
		pickers = {
			builtin = {
				previewer = false
			},
			help_tags = {
				theme = "dropdown"
			},
		}
	},
}
