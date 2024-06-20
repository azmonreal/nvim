local mappings = {
	[""] = {
		-- { { "n" }, "<leader>bf", function() vim.lsp.buf.format({ async = true }) end,                                  { desc = "Run lsp format command on current buffer" } },
		{ { "n" }, "gD",         vim.lsp.buf.declaration,                                                              { desc = "Go to symbol declaration" } },
		{ { "n" }, "gd",         vim.lsp.buf.definition,                                                               { desc = "Go to symbol definition" } },
		{ { "n" }, "K",          vim.lsp.buf.hover,                                                                    { desc = "Show hover window" } },
		{ { "n" }, "gi",         vim.lsp.buf.implementation,                                                           { desc = "Go to implementation" } },
		{ { "n" }, "<C-k>",      vim.lsp.buf.signature_help,                                                           { desc = "Show signature help" } },
		{ { "n" }, "<leader>rn", vim.lsp.buf.rename,                                                                   { desc = "Rename symbol under cursor" } },
		{ { "n" }, "gr",         vim.lsp.buf.references,                                                               { desc = "Find references to symbol" } },
		{ { "n" }, "<leader>ca", vim.lsp.buf.code_action,                                                              { desc = "Show available code actions" } },
		{ { "n" }, "gl",         vim.diagnostic.open_float,                                                            { desc = "Open diagnositcs floating window" } },
		{ { "n" }, "[d",         vim.diagnostic.goto_prev,                                                             { desc = "Go to previous diagnostic" } },
		{ { "n" }, "]d",         vim.diagnostic.goto_next,                                                             { desc = "Go to next diagnostic" } },
		{ { "n" }, "<leader>q",  vim.diagnostic.setloclist,                                                            { desc = "Lsp set loclist" } },
		{ { "n" }, "<leader>sh", function() vim.lsp.inlay_hint.enable(nil, not vim.lsp.inlay_hint.is_enabled(nil)) end },
	}
}

vim.api.nvim_create_autocmd("LspAttach",
	{
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			Utils.set_custom_maps(mappings)
		end
	}
)

return {
	{
		"williamboman/mason-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				config = true
			},
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls", "clangd", "texlab", "pylsp", "rust_analyzer"
			},
			automatic_installation = true,
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,

				["tsserver"] = function()
					require("lspconfig").tsserver.setup({
						init_options = {
							hostInfo = "neovim",
							preferences = {
								importModuleSpecifierPreference = "non-relative",
							}
						}
					})
				end,

				["lua_ls"] = function()
					require("neodev").setup()
					require("lspconfig").lua_ls.setup {
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
							},
						},
					}
				end,
				["clangd"] = function()
					require("lspconfig").clangd.setup({
						cmd = {
							"clangd",
							"--offset-encoding=utf-16",
						},
						on_attach = function(client, bufnr)
							local function handler(err, uri)
								if not uri or uri == "" then
									vim.api.nvim_echo({ { "Corresponding file cannot be determined" } }, false, {})
									return
								end
								local file_name = vim.uri_to_fname(uri)
								vim.api.nvim_cmd({
									cmd = "edit",
									args = { file_name },
								}, {})
							end
							local function client_request()
								vim.lsp.get_client_by_id(client.id).request("textDocument/switchSourceHeader", { uri = vim.uri_from_bufnr(0) }, handler, 0)
							end

							vim.keymap.set("n", "<leader>gs", client_request, {})
						end
					})
				end,
				["rust_analyzer"] = function()
				end
			}
		}
	},
}
