vim.wo[0][0].conceallevel = 2
vim.wo[0][0].wrap = true

Utils.setKeymaps({
	{
		{ "j",  "gj" },
		{ "k",  "gk" },
		{ "gj", "j" },
		{ "gk", "k" },
	}
}, { buffer = true })
