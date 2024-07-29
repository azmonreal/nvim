Utils.setKeymaps({
	{
		{ "<F4>",  "<cmd>CMake select_target<CR>" },
		{ "<F5>",  "<cmd>CMake build_and_run<CR>" },
		{ "<F29>", "<cmd>CMake build_and_debug<CR>" },
		{ "<F6>",  "<cmd>CMake run<CR>" },
		{ "<F30>", "<cmd>CMake debug<CR>" },
		{ "<C-B>", "<cmd>CMake build<CR>" },
	}
}, { buffer = true })
