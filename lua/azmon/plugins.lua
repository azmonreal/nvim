require("neodev").setup()

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
local capabilities = vim.lsp.protocol.make_client_capabilities()

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
	function(server_name)
		require("lspconfig")[server_name].setup {
			capabilities = capabilities,
		}
	end,

	["lua_ls"] = function()
		require("lspconfig").lua_ls.setup {
--			capabilities = capabilities,
			settings = {
				Lua = {
					workspace = {
						checkThirdParty = false,
					},
				},
			},
		}
	end,
	["clangd"] = function()
		require("lspconfig").clangd.setup {
			capabilities = capabilities,
			cmd = {
				"clangd",
				"--offset-encoding=utf-16",
			},
			on_attach = function(client, bufnr)
				local function handler(err, uri)
					if not uri or uri == "" then
						vim.api.nvim_echo({ { "Corresponding file cannot be determined" } }, false, {})
						return
					end
					local file_name = vim.uri_to_fname(uri)
					vim.api.nvim_cmd({
						cmd = "edit",
						args = { file_name },
					}, {})
				end
				local function client_request()
					vim.lsp.get_client_by_id(client.id).request("textDocument/switchSourceHeader", { uri = vim.uri_from_bufnr(0) }, handler, 0)
				end

				vim.keymap.set("n", "<leader>gs", client_request, {})
			end
		}
	end,
	["rust_analyzer"] = function() end
}

-- capabilities.textDocument.foldingRange = {
-- 	dynamicRegistration = false,
-- 	lineFoldingOnly = true,
-- }
local cmp = require("cmp")

local cmp_setup = {
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
}

local cmp_cmdline_setup = {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = { ignore_cmds = { "Man", "!" } }
		},
		{ name = "buffer" },
	}),

}

cmp.setup(cmp_setup)
cmp.setup.cmdline(":", cmp_cmdline_setup)

require("Comment").setup()

require("gitsigns").setup {
	signs = {
		add          = { text = "│" },
		change       = { text = "│" },
		delete       = { text = "_" },
		topdelete    = { text = "‾" },
		changedelete = { text = "~" },
		untracked    = { text = "┆" },
	},

	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then return "]c" end
			vim.schedule(function() gs.next_hunk() end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then return "[c" end
			vim.schedule(function() gs.prev_hunk() end)
			return "<Ignore>"
		end, { expr = true })
	end
}

require "nvim-treesitter.configs".setup {
	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
		disable = { "latex" },
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn", -- set to `false` to disable one of the mappings
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
}

require("project_nvim").setup(
	{
		-- Manual mode doesn't automatically change your root directory, so you have
		-- the option to manually do so using `:ProjectRoot` command.
		manual_mode = false,

		-- Methods of detecting the root directory. **"lsp"** uses the native neovim
		-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
		-- order matters: if one is not detected, the other is used as fallback. You
		-- can also delete or rearangne the detection methods.
		detection_methods = {  "lsp", "pattern",},

		-- All the patterns used to detect root dir, when **"pattern"** is in
		-- detection_methods
		patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "CMakeLists.txt" },

		-- Table of lsp clients to ignore by name
		-- eg: { "efm", ... }
		ignore_lsp = { "lua_ls"},

		-- Don't calculate root dir on specific directories
		-- Ex: { "~/.cargo/*", ... }
		exclude_dirs = {},

		-- Show hidden files in telescope
		show_hidden = false,

		-- When set to false, you will get a message when project.nvim changes your
		-- directory.
		silent_chdir = true,

		-- What scope to change the directory, valid options are
		-- * global (default)
		-- * tab
		-- * win
		scope_chdir = "global",

		-- Path where project.nvim will store the project history for use in
		-- telescope
		datapath = vim.fn.stdpath("data"),
	}
)

require("copilot").setup()

require("cmake").setup({
})
