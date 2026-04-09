vim.api.nvim_create_autocmd("LspAttach",
	{
		pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.objc", "*.objcpp", "*.cu" },
		group = vim.api.nvim_create_augroup("UserLspConfig", { clear = false }),
		callback = function ()
			vim.keymap.set("n", "<leader>gs", "<CMD>LspClangdSwitchSourceHeader<CR>", { buf = 0 })
		end,
	}
)

return {}
