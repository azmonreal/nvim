return {
	"folke/snacks.nvim",
	init = function ()
		Utils.setKeymaps({
			{
				{ "<M-n>", function () Snacks.words.jump(1, true) end },
				{ "<M-p>", function () Snacks.words.jump(-1, true) end },
			},
			{
				{ "<leader>z", function () Snacks.zen.zoom() end },
			},
			["<leader>f"] = {
				{ "<leader>", function () Snacks.picker() end,               { desc = "Open snacks picker list" } },
				{ "g",        function () Snacks.picker.grep() end,          { desc = "Open snacks live grep" } },
				{ "/",        function () Snacks.picker.lines() end,         { desc = "Open snacks current buffer fuzzy find" } },
				{ "b",        function () Snacks.picker.buffers() end,       { desc = "Open snacks buffer list" } },
				{ "h",        function () Snacks.picker.help() end,          { desc = "Open snacks help search" } },
				{ "k",        function () Snacks.picker.keymaps() end,       { desc = "Open snacks keymap list" } },
				{ "r",        function () Snacks.picker.registers() end,     { desc = "Open snacks register list" } },
				{ "j",        function () Snacks.picker.jumps() end,         { desc = "Open snacks jumplist" } },
				{ "f",        function () Snacks.picker.files() end,         { desc = "Open snacks file list" } },
				{ "r",        function () Snacks.picker.recent() end,        { desc = "Open snacks old files" } },
				{ "p",        function () Snacks.picker.projects() end,      { desc = "Open snacks projects" } },
				{ "s",        function () Snacks.picker.lsp_symbols() end,   { desc = "Open snacks lsp symbols" } },
				{ "z",        function () Snacks.picker.zoxide() end,        { desc = "Open snacks zoxide" } },
				{ "t",        function () Snacks.picker.todo_comments() end, { desc = "Open snacks todo comments" } },
			},
			{
				{ "_", function () Snacks.picker.explorer({}) end, { desc = "Open snacks zoxide" } },
			},
		})
	end,
	---@module "snacks"
	---@type snacks.Config
	opts = {
		words = { enabled = true },
		zen = {},
		-- lazy.nvim
		explorer = {
			-- your explorer configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		picker = {
			actions = require("trouble.sources.snacks").actions,
			layout = "custom",
			sources = {
				explorer = {
					layout = {
						layout = {
							position = "right",
						},
					},
				},
				help = {
					layout = {
						layout = {
							box = "vertical",
							width = 0.8,
							height = 0.5,
							row = 1,
							border = "none",
							{ win = "input", height = 1,          border = "bottom",   title = "{title} {live} {flags}", title_pos = "center" },
							{ win = "list",  title = " Results ", title_pos = "center" },
							{
								win = "preview",
								title = "{preview:Preview}",
								border = "top",
								title_pos = "center",
							},
						},
					},
				},
			},
			layouts = {
				custom = {
					layout = {
						box = "horizontal",
						width = 0.8,
						height = 0.9,
						border = "none",
						{
							box = "vertical",
							{ win = "input", height = 1,          border = "bottom",   title = "{title} {live} {flags}", title_pos = "center" },
							{ win = "list",  title = " Results ", title_pos = "center" },
						},
						{
							win = "preview",
							title = "{preview:Preview}",
							width = 0.45,
							border = "left",
							title_pos = "center",
						},
					},
				},
			},
			win = {
				input = {
					keys = {
						["<c-n>"] = { "history_forward", mode = { "i", "n" } },
						["<c-p>"] = { "history_back", mode = { "i", "n" } },
						["<c-x>"] = { "trouble_open", mode = { "n", "i" } },
						["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
						["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
					},
				},
			},
		},
	},
}
