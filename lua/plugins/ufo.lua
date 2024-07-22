return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			branch = "0.10",
			config = function ()
				local builtin = require("statuscol.builtin")
				require("statuscol").setup({

					relculright = true,
					segments = {
						{ text = { builtin.foldfunc, " " },                                  click = "v:lua.ScFa" },
						{
							sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true, },
							click = "v:lua.ScSa"
						},
						{ text = { builtin.lnumfunc, " " },                                  click = "v:lua.ScLa" },
						{ sign = { namespace = { "gitsign*" }, maxwidth = 1, auto = false }, click = "v:lua.ScSa" },
						{ sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true },     click = "v:lua.ScSa" },
					},
				})
			end,
		},
	},
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		open_fold_hl_timeout = 300,
		--provider_selector = function(a)
		--return "lsp"
		--end,
	},

	init = function ()
		vim.keymap.set("n", "zR", function ()
			require("ufo").openAllFolds()
		end)
		vim.keymap.set("n", "zM", function ()
			require("ufo").closeAllFolds()
		end)
	end,
}
