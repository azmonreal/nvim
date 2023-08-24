local function set_custom_maps(customMaps)
	for _, map_group in pairs(customMaps) do
		if map_group.leader == nil then map_group.leader = "" end
		for _, keymap in pairs(map_group.mappings) do
			local mode, rh, lf, opts = unpack(keymap)

			vim.keymap.set(mode, map_group.leader .. rh, lf, opts)
		end
	end
end

local telescope = require("telescope.builtin")
local telescope_ldr = "f"

local custom_maps = {
	{
		mappings = {
			{ { "n" }, "<C-_>",   "<cmd>noh<CR>", { desc = "Stop highlighting search pattern" } },
			{ { "n" }, "<Tab>",   "<cmd>bn<CR>",  { desc = "Switch to next buffer" } },
			{ { "n" }, "<S-Tab>", "<cmd>bp<CR>",  { desc = "Switch to previous buffer" } },
			{ { "n" }, "<C-k>",   "<C-w>k",       { desc = "Move cursor to window below current one" } },
			{ { "n" }, "<C-j>",   "<C-w>j",       { desc = "Move cursor to window above current one" } },
			{ { "n" }, "<C-h>",   "<C-w>h",       { desc = "Move cursor to window left of current one" } },
			{ { "n" }, "<C-l>",   "<C-w>l",       { desc = "Move cursor to window right of current one" } },
		}
	},
	lsp = {
		mappings = {
			{ { "n" }, "<leader>bf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Run lsp format command on current buffer" } },
			{ { "n" }, "gD",         vim.lsp.buf.declaration,                             { desc = "Go to symbol declaration" } },
			{ { "n" }, "gd",         vim.lsp.buf.definition,                              { desc = "Go to symbol definition" } },
			{ { "n" }, "K",          vim.lsp.buf.hover,                                   { desc = "Show hover window" } },
			{ { "n" }, "gi",         vim.lsp.buf.implementation,                          { desc = "Go to implementation" } },
			-- { { "n" }, "<C-k>",      vim.lsp.buf.signature_help,                          { desc = "Show signature help" } },
			{ { "n" }, "<leader>rn", vim.lsp.buf.rename,                                  { desc = "Rename symbol under cursor" } },
			{ { "n" }, "gr",         vim.lsp.buf.references,                              { desc = "Find references to symbol" } },
			{ { "n" }, "<leader>ca", vim.lsp.buf.code_action,                             { desc = "Show available code actions" } },
			{ { "n" }, "gl",         vim.diagnostic.open_float,                           { desc = "Open diagnositcs floating window" } },
			{ { "n" }, "[d",         vim.diagnostic.goto_prev,                            { desc = "Go to previous diagnostic" } },
			{ { "n" }, "]d",         vim.diagnostic.goto_next,                            { desc = "Go to next diagnostic" } },
			{ { "n" }, "<leader>q",  vim.diagnostic.setloclist,                           { desc = "Lsp set loclist" } },
		}
	},
	telescope = {
		leader = "<leader>" .. telescope_ldr,
		mappings = {
			{ { "n" }, "<leader>", telescope.builtin,                   { desc = "Open telescope picker list" } },
			{ { "n" }, "g",        telescope.live_grep,                 { desc = "Open telescope live grep" } },
			{ { "n" }, "/",        telescope.current_buffer_fuzzy_find, { desc = "Open telescope current buffer fuzzy find" } },
			{ { "n" }, "b",        telescope.buffers,                   { desc = "Open telescope buffer list" } },
			{ { "n" }, "h",        telescope.help_tags,                 { desc = "Open telescope help search" } },
			{ { "n" }, "k",        telescope.keymaps,                   { desc = "Open telescope keymap list" } },
			{ { "n" }, "r",        telescope.registers,                 { desc = "Open telescope register list" } },
			{ { "n" }, "j",        telescope.jumplist,                  { desc = "Open telescope jumplist" } },
			{ { "n" }, "f",        telescope.find_files,                { desc = "Open telescope file list" } },
			{ { "n" }, "r",        telescope.oldfiles,                  { desc = "Open telescope old files" } },
		}
	},
}

set_custom_maps(custom_maps)
