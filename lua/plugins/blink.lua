vim.api.nvim_set_hl(0, "BlinkCmpKindAbbr", { fg = "#505050" })

return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	-- dependencies = "rafamadriz/friendly-snippets",
	dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },

	-- use a release tag to download pre-built binaries
	version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		completion = {
			list = {
				selection = { preselect = false, auto_insert = false },
			},
			menu = {
				auto_show = false,
				draw = {
					columns = { { "kind_icon", gap = 1 }, { "label", "label_description", gap = 1 }, { "kind" } },
					components = {
						kind = {
							highlight = "BlinkCmpKindAbbr",
						},
					},
				},
			},
			ghost_text = { enabled = true },
			documentation = { auto_show = true, auto_show_delay_ms = 0 },
		},

		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<C-y>"] = { "select_and_accept" },

			-- ["<Up>"] = { "select_prev", "fallback" },
			-- ["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			-- ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		snippets = {
			preset = "luasnip",
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer", "dadbod" },
			providers = {
				buffer = { min_keyword_length = 3 },
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink", -- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
				dadbod = {

					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
				},
			},
		},

		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
