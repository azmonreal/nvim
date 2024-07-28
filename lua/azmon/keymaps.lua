local custom_maps = {
	[""] = {
		{ { "n" }, "]b",                 "<cmd>bn<CR>",                      { desc = "Switch to next buffer" } },
		{ { "n" }, "[b",                 "<cmd>bp<CR>",                      { desc = "Switch to previous buffer" } },

		{ { "n" }, "Zz",                 function () vim.cmd([[w|bd]]) end,  { desc = "Save and delete current buffer" } },
		{ { "n" }, "ZZ",                 function () vim.cmd([[wa|qa]]) end, { desc = "Save all buffers and quit" } },
		{ { "n" }, "Zq",                 function () vim.cmd([[bd!]]) end,   { desc = "Delete current buffer without saving" } },
		{ { "n" }, "ZQ",                 function () vim.cmd([[qa!]]) end,   { desc = "Exit all buffers without saving" } },
	}
}

Utils.set_custom_maps(custom_maps)
