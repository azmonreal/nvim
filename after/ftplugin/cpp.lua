local mappings = {
	[""] = {
		{ { "n" }, "<F4>",  "<cmd>CMake select_target<CR>",   { buffer = true } },
		{ { "n" }, "<F5>",  "<cmd>CMake build_and_run<CR>",   { buffer = true } },
		{ { "n" }, "<F29>", "<cmd>CMake build_and_debug<CR>", { buffer = true } },
		{ { "n" }, "<F6>",  "<cmd>CMake run<CR>",             { buffer = true } },
		{ { "n" }, "<F30>", "<cmd>CMake debug<CR>",           { buffer = true } },
		{ { "n" }, "<C-B>", "<cmd>CMake build<CR>",           { buffer = true } },
	}
}

Utils.set_custom_maps(mappings)
