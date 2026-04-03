return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"mfussenegger/nvim-dap-python",
			config = function ()
				require("dap-python").setup("python")
			end,
		},
		{
			"rcarriga/nvim-dap-ui",
			opts = {},
		},
		"nvim-neotest/nvim-nio",
	},
	lazy = true,
	init = function ()
		Utils.setKeymaps(
			{
				{
					{ "<F8>",  "<cmd>DapContinue<CR>" },
					{ "<F9>",  "<cmd>DapToggleBreakpoint<CR>" },
					{ "<F10>", "<cmd>DapStepOver<CR>" },
					{ "<F11>", "<cmd>DapStepInto<CR>" },
					{ "<F12>", "<cmd>DapStepOut<CR>" },
				},
			}
		)
	end,
	config = function ()
		local dap = require("dap")

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "OpenDebugAD7", -- adjust as needed, must be absolute path
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function ()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function ()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}
	end,
}
