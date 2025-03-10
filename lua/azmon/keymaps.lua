Utils.setKeymaps({
	{
		{ "]T",    "<cmd>tabnext<CR>", { desc = "Switch to next tab" } },
		{ "[T",    "<cmd>tabprev<CR>", { desc = "Switch to previous tab" } },

		{ "<M-J>", "<cmd>m +1<CR>==",  { desc = "Move line one below" } },
		{ "<M-K>", "<cmd>m -2<CR>==",  { desc = "Move line one above" } },
		{ "<M-J>", ":m '>+<CR>gv=gv",  { desc = "Move selection one below" },       mode = "v" },
		{ "<M-K>", ":m '<-2<CR>gv=gv", { desc = "Move selection one above" },       mode = "v" },
	},

	["Z"] = {
		{ "z", function () vim.cmd([[w|bd]]) end,  { desc = "Save and delete current buffer" } },
		{ "Z", function () vim.cmd([[wa|qa]]) end, { desc = "Save all buffers and quit" } },
		{ "q", function () vim.cmd([[bd!]]) end,   { desc = "Delete current buffer without saving" } },
		{ "Q", function () vim.cmd([[qa!]]) end,   { desc = "Exit all buffers without saving" } },
	},
})
