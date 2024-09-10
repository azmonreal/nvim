Utils.setKeymaps({
	{
		{ "]b", "<cmd>bn<CR>", { desc = "Switch to next buffer" } },
		{ "[b", "<cmd>bp<CR>", { desc = "Switch to previous buffer" } },
		{ "]q", "<cmd>cn<CR>", { desc = "Select next quickfix item" } },
		{ "[q", "<cmd>cp<CR>", { desc = "Select previous quickfix item" } },
	},

	["Z"] = {
		{ "z", function () vim.cmd([[w|bd]]) end,  { desc = "Save and delete current buffer" } },
		{ "Z", function () vim.cmd([[wa|qa]]) end, { desc = "Save all buffers and quit" } },
		{ "q", function () vim.cmd([[bd!]]) end,   { desc = "Delete current buffer without saving" } },
		{ "Q", function () vim.cmd([[qa!]]) end,   { desc = "Exit all buffers without saving" } },
	}
})
