local M = {}

-- TODO: opts not as a subtable i.e. keymap = {lhs, rhs, mdoe="", buffer=true, ...}
-- TODO: support nesting keymap groups with different opts or even lleader
M.setKeymaps = function (customMaps, gopts)
	local setKeymap = function (keymap, lleader)
		lleader = lleader or ""
		local lhs, rhs, opts = unpack(keymap)

		local mode = keymap["mode"] or "n"

		lhs = type(lhs) == "string" and { lhs } or lhs

		opts = opts or {}
		opts = gopts and vim.tbl_deep_extend("force", gopts, opts) or opts

		for _, v in ipairs(lhs) do
			vim.keymap.set(mode, lleader .. v, rhs, opts)
		end
	end

	for i, map_group in ipairs(customMaps) do
		for _, keymap in pairs(map_group) do
			setKeymap(keymap)
		end
		table.remove(customMaps, i)
	end

	for lleader, map_group in pairs(customMaps) do
		for _, keymap in pairs(map_group) do
			setKeymap(keymap, lleader)
		end
	end
end

return M
