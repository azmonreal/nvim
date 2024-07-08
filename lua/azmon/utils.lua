local M = {}

-- TODO: allow for maps arg to be ungrouped mappings, specifying lleader as another arg
M.set_custom_maps = function(customMaps)
	for lleader, map_group in pairs(customMaps) do
		for _, keymap in pairs(map_group) do
			local mode, rhs, lf, opts = unpack(keymap)
			rhs = type(rhs) == "string" and { rhs } or rhs

			for _, rh in ipairs(rhs) do
				vim.keymap.set(mode, lleader .. rh, lf, opts)
			end
		end
	end
end

return M
