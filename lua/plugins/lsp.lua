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
		end
	}
)

local capabilities = require("blink.cmp").get_lsp_capabilities()

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
				"lua_ls", "clangd", "texlab", "basedpyright", "ruff", "ts_ls"
			},
			automatic_installation = true,
			handlers = {
				function (server_name)
					require("lspconfig")[server_name].setup({ capabilities = capabilities, })
				end,

				["ts_ls"] = function ()
					require("lspconfig").ts_ls.setup({
						capabilities = capabilities,
						init_options = {
							hostInfo = "neovim",
							preferences = {
								importModuleSpecifierPreference = "non-relative",
							}
						}
					})
				end,
				["basedpyright"] = function ()
					require("lspconfig").basedpyright.setup({
						capabilities = capabilities,
						settings = {
							basedpyright = {
								reportUnkownVariable = false,
								typeCheckingMode = "standard",
							}
						}
					})
				end,

				["lua_ls"] = function ()
					require("lspconfig").lua_ls.setup {
						capabilities = capabilities,
						settings = {
							Lua = {
								-- workspace = {
								-- 	checkThirdParty = false,
								-- },
								diagnostics = {
									neededFileStatus = {
										["codestyle-check"] = "Any"
									},
								},
							},
						},
					}
				end,
				["clangd"] = function ()
					require("lspconfig").clangd.setup({
						capabilities = capabilities,
						cmd = {
							"clangd",
							"--offset-encoding=utf-16",
						},
						on_attach = function (client, bufnr)
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
								vim.lsp.get_client_by_id(client.id).request("textDocument/switchSourceHeader",
									{ uri = vim.uri_from_bufnr(0) }, handler, 0)
							end

							vim.keymap.set("n", "<leader>gs", client_request, {})
						end
					})
				end,
			}
		}
	},
}
