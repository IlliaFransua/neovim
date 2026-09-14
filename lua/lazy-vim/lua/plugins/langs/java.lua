return {
	{ "mfussenegger/nvim-jdtls", enabled = false },
	{
		"nvim-java/nvim-java",
		config = function()
			require("java").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			servers = {
				jdtls = {},
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				-- java = { "checkstyle" },
				java = {},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				java = { "google-java-format" },
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"google-java-format",
				"checkstyle",
			})
		end,
	},
}
