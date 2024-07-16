local mappings = {
	["<leader>f"] = {
		{ { "n" }, "<leader>", function () require("telescope.builtin").builtin() end,                   { desc = "Open telescope picker list" } },
		{ { "n" }, "g",        function () require("telescope.builtin").live_grep() end,                 { desc = "Open telescope live grep" } },
		{ { "n" }, "/",        function () require("telescope.builtin").current_buffer_fuzzy_find() end, { desc = "Open telescope current buffer fuzzy find" } },
		{ { "n" }, "b",        function () require("telescope.builtin").buffers() end,                   { desc = "Open telescope buffer list" } },
		{ { "n" }, "h",        function () require("telescope.builtin").help_tags() end,                 { desc = "Open telescope help search" } },
		{ { "n" }, "k",        function () require("telescope.builtin").keymaps() end,                   { desc = "Open telescope keymap list" } },
		{ { "n" }, "r",        function () require("telescope.builtin").registers() end,                 { desc = "Open telescope register list" } },
		{ { "n" }, "j",        function () require("telescope.builtin").jumplist() end,                  { desc = "Open telescope jumplist" } },
		{ { "n" }, "f",        function () require("telescope.builtin").find_files() end,                { desc = "Open telescope file list" } },
		{ { "n" }, "r",        function () require("telescope.builtin").oldfiles() end,                  { desc = "Open telescope old files" } },
		{ { "n" }, "p",        function () require("telescope").extensions.projects.projects() end,      { desc = "Open telescope projects" } },
		{ { "n" }, "s",        function () require("telescope.builtin").lsp_document_symbols() end,      { desc = "Open telescope projects" } },
	}
}

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

	config = function (_, opts)
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		opts.defaults.file_sorter = require("telescope.sorters").get_fuzzy_file
		opts.defaults.generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter

		opts.defaults.mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
			n = {
				["<esc>"] = actions.close,
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["q"] = actions.close,
			},
		}

		telescope.setup(opts)

		local telescope_extensions = {
			"projects",
			"zoxide",
			"luasnip",
			"git_diffs",
			"lazy",
		}

		for _, e in pairs(telescope_extensions) do
			telescope.load_extension(e)
		end

		Utils.set_custom_maps(mappings)
	end,

	opts = {
		defaults = {
			sorting_strategy = "ascending",
			layout_config = {
				prompt_position = "top",
			},
			path_display = "smart",
			border = false,
		},
		pickers = {
			builtin = {
				previewer = false
			},
			help_tags = {
				theme = "dropdown",
				border = false,
			},
		}
	},
}
