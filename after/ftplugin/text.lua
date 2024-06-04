vim.wo[0][0].wrap = true

Utils.set_custom_maps({
	[""] = {
		{ "n", "j",  "gj" },
		{ "n", "k",  "gk" },
		{ "n", "gj", "j" },
		{ "n", "gk", "k" },
	}
})
