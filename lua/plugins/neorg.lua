return {
	{
		"nvim-neorg/neorg",
		version = "1.9", -- Pin Neorg to the latest stable release
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
