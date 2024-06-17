local custom_maps = {
	[""] = {
		{ { "n" }, "<C-_>",      "<cmd>noh<CR>",                               { desc = "Stop highlighting search pattern" } },
		{ { "n" }, "]b",         "<cmd>bn<CR>",                                { desc = "Switch to next buffer" } },
		{ { "n" }, "[b",         "<cmd>bp<CR>",                                { desc = "Switch to previous buffer" } },

		{ { "n" }, "Zz",         function() vim.cmd([[w|bd]]) end,             { desc = "" } },
		{ { "n" }, "ZZ",         function() vim.cmd([[wa|qa]]) end,            { desc = "" } },
		{ { "n" }, "Zq",         function() vim.cmd([[bd!]]) end,              { desc = "" } },
		{ { "n" }, "ZQ",         function() vim.cmd([[qa!]]) end,              { desc = "" } },
	}
}

Utils.set_custom_maps(custom_maps)
