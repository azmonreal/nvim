local ts_inlayHints = {
	includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
	includeInlayParameterNameHintsWhenArgumentMatchesName = true,
	includeInlayVariableTypeHints = true,
	includeInlayFunctionParameterTypeHints = true,
	includeInlayVariableTypeHintsWhenTypeMatchesName = true,
	includeInlayPropertyDeclarationTypeHints = true,
	includeInlayFunctionLikeReturnTypeHints = true,
	includeInlayEnumMemberValueHints = true,
}

return {
	init_options = {
		preferences = {
			importModuleSpecifierPreference = "non-relative",
		},
	},
	settings = {
		typescript = {
			inlayHints = ts_inlayHints,
		},
		javascript = {
			inlayHints = ts_inlayHints,
		},
	},
}
