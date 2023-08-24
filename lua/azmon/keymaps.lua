local function SetKeymaps(keymapList)
	for _, keymap in pairs(keymapList) do
		vim.keymap.set(unpack(keymap))
	end
end

local keymaps = {
	{ { "n" }, "<C-_>",      "<cmd>noh<CR>",             { desc = "Stop highlighting search pattern" } },
	{ { "n" }, "<Tab>",      "<cmd>bn<CR>",              { desc = "Switch to next buffer" } },
	{ { "n" }, "<S-Tab>",    "<cmd>bp<CR>",              { desc = "Switch to previous buffer" } },
	{ { "n" }, "<C-k>",      "<C-w>k",                   { desc = "Move cursor to window below current one" } },
	{ { "n" }, "<C-j>",      "<C-w>j",                   { desc = "Move cursor to window above current one" } },
	{ { "n" }, "<C-h>",      "<C-w>h",                   { desc = "Move cursor to window left of current one" } },
	{ { "n" }, "<C-l>",      "<C-w>l",                   { desc = "Move cursor to window right of current one" } },

	{ { "n" }, "<leader>bf", vim.lsp.buf.format,         { desc = "Run lsp format command on current buffer" } },
	{ { "n" }, "gD",         vim.lsp.buf.declaration,    { desc = "Go to symbol declaration" } },
	{ { "n" }, "gd",         vim.lsp.buf.definition,     { desc = "Go to symbol definition" } },
	{ { "n" }, "K",          vim.lsp.buf.hover,          { desc = "Show hover window" } },
	{ { "n" }, "gi",         vim.lsp.buf.implementation, { desc = "Go to implementation" } },
	-- {{ "n" }, "<C-k>", vim.lsp.buf.signature_help, {desc = "Show signature help"}},
	{ { "n" }, "<leader>rn", vim.lsp.buf.rename,         { desc = "Rename symbol under cursor" } },
	{ { "n" }, "gr",         vim.lsp.buf.references,     { desc = "Find references to symbol" } },
	{ { "n" }, "<leader>ca", vim.lsp.buf.code_action,    { desc = "Show available code actions" } },
	{ { "n" }, "gl",         vim.diagnostic.open_float,  { desc = "Open diagnositcs floating window" } },
	{ { "n" }, "[d",         vim.diagnostic.goto_prev,   { desc = "Go to previous diagnostic" } },
	{ { "n" }, "]d",         vim.diagnostic.goto_next,   { desc = "Go to next diagnostic" } },
	{ { "n" }, "<leader>q",  vim.diagnostic.setloclist,  { desc = "Lsp set loclist" } },
}

SetKeymaps(keymaps)

vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting([{asyng=true}])' ]])


local telescope = require("telescope.builtin")

local telescope_ldr = "f"

local telescope_keymaps = {
	{ { "n" }, telescope_ldr, telescope.builtin,                   { desc = "Open telescope picker list" } },
	{ { "n" }, "g",           telescope.live_grep,                 { desc = "Open telescope live grep" } },
	{ { "n" }, "/",           telescope.current_buffer_fuzzy_find, { desc = "Open telescope current buffer fuzzy find" } },
	{ { "n" }, "b",           telescope.buffers,                   { desc = "Open telescope buffer list" } },
	{ { "n" }, "h",           telescope.help_tags,                 { desc = "Open telescope help search" } },
	{ { "n" }, "k",           telescope.keymaps,                   { desc = "Open telescope keymap list" } },
	{ { "n" }, "r",           telescope.registers,                 { desc = "Open telescope register list" } },
	{ { "n" }, "j",           telescope.jumplist,                  { desc = "Open telescope jumplist" } },

}

local function SetTelescopeKeyMaps(keymapList)
	for _, keymap in pairs(keymapList) do
		local mode, rh, lf, opts = unpack(keymap)

		vim.keymap.set(mode, "<leader>" .. telescope_ldr .. rh, lf, opts)
	end
end


SetTelescopeKeyMaps(telescope_keymaps)
