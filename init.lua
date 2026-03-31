Utils = require("azmon.utils")

local modules = {
	"azmon.options",
	"azmon.lazy",
	"azmon.keymaps",
	"azmon.commands",
}

for _, v in pairs(modules) do
	local status, error = pcall(require, v)
	if not status then
		vim.notify(error)
	end
end
