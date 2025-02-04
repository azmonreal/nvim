vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.laststatus = 3
vim.o.winbar = "%f"

vim.o.cursorline = true
vim.o.cursorlineopt = "number"

vim.o.scrolloff = 5

vim.o.colorcolumn = "80,120"

vim.o.breakindent = true
vim.opt.breakindentopt = { "list:-1" }

vim.g.mapleader = " "

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"

vim.o.wrap = false
vim.o.linebreak = true

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.o.pumheight = 10

vim.filetype.add({
	extension = {
		xaml = "xml",
		cc = "cpp",
	},
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose"
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function ()
		vim.opt_local.formatoptions:remove({ "o" })
	end,
})

-- vim.o.statuscolumn = '%=%l%s%#FoldColumn#%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? " " : " ") : "  " }%*'

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function ()
		vim.highlight.on_yank({ timeout = 500 })
	end
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function (args)
		local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line("$")
		local not_commit = vim.b[args.buf].filetype ~= "commit"

		if valid_line and not_commit then
			vim.cmd([[normal! g`"]])
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"checkhealth",
		"fugitive*",
		"Neogit*",
		"git",
		"help",
		"lspinfo",
		"netrw",
		"notify",
		"qf",
		"query",
	},
	callback = function ()
		vim.keymap.set("n", "q", vim.cmd.close, { desc = "Close the current buffer", buffer = true })
	end,
})
