return {
	{
		"nvim-neorg/neorg",
		version = "1.9", -- Pin Neorg to the latest stable release
		---@module "neorg"
		---@type neorg.configuration.user
		opts = {
			load = {
				["core.defaults"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						-- Format: <name_of_workspace> = <path_to_workspace_root>
					},
				},
			},
		},
	},
}
