Utils = require("azmon.utils")

local modules = {
	"options",
	"lazy",
	"keymaps",
}

for _, v in pairs(modules) do
	local status, error = pcall(require, "azmon." .. v)
	if not status then
		vim.notify(error)
	end
end
