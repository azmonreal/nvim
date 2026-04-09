local mappings = {
	{
		{ "gD",         vim.lsp.buf.declaration,                                                        { desc = "Go to symbol declaration" } },
		{ "gd",         vim.lsp.buf.definition,                                                         { desc = "Go to symbol definition" } },
		{ "K",          vim.lsp.buf.hover,                                                              { desc = "Show hover window" } },
		{ "gl",         vim.diagnostic.open_float,                                                      { desc = "Open diagnositcs floating window" } },
		{ "<leader>q",  vim.diagnostic.setloclist,                                                      { desc = "Lsp set loclist" } },
		{ "<leader>sh", function () vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle inlay hints" } },
		{ "gK", function ()
			local new_config = not vim.diagnostic.config().virtual_lines
			vim.print("Setting virtual_lines to " .. tostring(new_config))
			vim.diagnostic.config({ virtual_lines = new_config and { current_line = true } })
		end, { desc = "Toggle diagnostic virtual_lines" } },
	},
}

vim.api.nvim_create_autocmd("LspAttach",
	{
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function (ev)
			Utils.setKeymaps(mappings)
		end,
	}
)

return {
	{
		"williamboman/mason-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				config = true,
			},
			"neovim/nvim-lspconfig",
		},
		opts = true,
	},
}
