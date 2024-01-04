vim.api.nvim_create_autocmd("LspAttach",
	{
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			vim.keymap.set({ "n" }, "<leader>bf", function() vim.lsp.buf.format({ async = true }) end, { desc = "Run lsp format command on current buffer" })
			vim.keymap.set({ "n" }, "gD", vim.lsp.buf.declaration, { desc = "Go to symbol declaration" })
			vim.keymap.set({ "n" }, "gd", vim.lsp.buf.definition, { desc = "Go to symbol definition" })
			vim.keymap.set({ "n" }, "K", vim.lsp.buf.hover, { desc = "Show hover window" })
			vim.keymap.set({ "n" }, "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
			vim.keymap.set({ "i", "n" }, "<C-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
			vim.keymap.set({ "n" }, "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol under cursor" })
			vim.keymap.set({ "n" }, "gr", vim.lsp.buf.references, { desc = "Find references to symbol" })
			vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show available code actions" })
			vim.keymap.set({ "n" }, "gl", vim.diagnostic.open_float, { desc = "Open diagnositcs floating window" })
			vim.keymap.set({ "n" }, "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			vim.keymap.set({ "n" }, "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set({ "n" }, "<leader>q", vim.diagnostic.setloclist, { desc = "Lsp set loclist" })
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
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
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
