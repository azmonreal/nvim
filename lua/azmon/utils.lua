local M = {}

-- TODO: allow for maps arg to be ungrouped mappings, specifying lleader as another arg
M.set_custom_maps = function (customMaps)
	for lleader, map_group in pairs(customMaps) do
		for _, keymap in pairs(map_group) do
			local mode, lhs, rhs, opts = unpack(keymap)
			lhs = type(lhs) == "string" and { lhs } or lhs

			for _, v in ipairs(lhs) do
				vim.keymap.set(mode, lleader .. v, rhs, opts)
			end
		end
	end
end

return M
