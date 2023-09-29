local function set_custom_maps(customMaps)
	for _, map_group in pairs(customMaps) do
		if map_group.leader == nil then map_group.leader = "" end
		for _, keymap in pairs(map_group.mappings) do
			local mode, rh, lf, opts = unpack(keymap)

			vim.keymap.set(mode, map_group.leader .. rh, lf, opts)
		end
	end
end


local custom_maps = {
	{
		mappings = {
			{ { "n" }, "<C-_>",      "<cmd>noh<CR>",                               { desc = "Stop highlighting search pattern" } },
			{ { "n" }, "<Tab>",      "<cmd>bn<CR>",                                { desc = "Switch to next buffer" } },
			{ { "n" }, "<S-Tab>",    "<cmd>bp<CR>",                                { desc = "Switch to previous buffer" } },
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
}

set_custom_maps(custom_maps)
