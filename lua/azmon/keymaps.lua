local function set_custom_maps(customMaps)
	for _, map_group in pairs(customMaps) do
		if map_group.leader == nil then map_group.leader = "" end
		for _, keymap in pairs(map_group[1]) do
			local mode, rh, lf, opts = unpack(keymap)

			vim.keymap.set(mode, map_group.leader .. rh, lf, opts)
		end
	end
end


local custom_maps = {
	{
		{
			{ { "n" }, "<C-_>",      "<cmd>noh<CR>",                               { desc = "Stop highlighting search pattern" } },
			{ { "n" }, "]b",      "<cmd>bn<CR>",                                { desc = "Switch to next buffer" } },
			{ { "n" }, "[b",    "<cmd>bp<CR>",                                { desc = "Switch to previous buffer" } },
			{ { "n" }, "<C-k>",      "<cmd> TmuxNavigateUp<CR>",                   { desc = "Move cursor to window below current one (tmux integrated)" } },
			{ { "n" }, "<C-j>",      "<cmd> TmuxNavigateDown<CR>",                 { desc = "Move cursor to window above current one (tmux integrated)" } },
			{ { "n" }, "<C-h>",      "<cmd> TmuxNavigateLeft<CR>",                 { desc = "Move cursor to window left of current one (tmux integrated)" } },
			{ { "n" }, "<C-l>",      "<cmd> TmuxNavigateRight<CR>",                { desc = "Move cursor to window right of current one (tmux integrated)" } },
			{ { "n" }, "<leader>cd", require("project_nvim.project").on_buf_enter, { desc = "" } },

			{ { "n" }, "<leader>gt", function() vim.cmd([[LazyGit]]) end,          { desc = "" } },

			{ { "n" }, "Zz",         function() vim.cmd([[w|bd]]) end,             { desc = "" } },
			{ { "n" }, "ZZ",         function() vim.cmd([[wa|qa]]) end,            { desc = "" } },
			{ { "n" }, "Zq",         function() vim.cmd([[bd!]]) end,              { desc = "" } },
			{ { "n" }, "ZQ",         function() vim.cmd([[qa!]]) end,              { desc = "" } },
		}
	},
}

set_custom_maps(custom_maps)
