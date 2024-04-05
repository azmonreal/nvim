vim.wo.conceallevel = 2
vim.wo.wrap = true
vim.wo.linebreak = true

Utils.set_custom_maps({
	[""] = {
		{ "n", "j",  "gj" },
		{ "n", "k",  "gk" },
		{ "n", "gj", "j" },
		{ "n", "gk", "k" },
	}
})


vim.g.vimtex_view_method = "zathura"
