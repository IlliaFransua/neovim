return {
	{ import = "lazyvim.plugins.extras.coding.luasnip" },

	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()

			require("luasnip").filetype_extend("typescriptreact", { "javascript", "javascriptreact" })
			require("luasnip").filetype_extend("javascriptreact", { "javascript" })
		end,
	},

	{
		"saghen/blink.cmp",
		opts = {
			keymap = {
				fuzzy = {
					implementation = "lua",
				},
				preset = "default",
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
			},
		},
	},
}
