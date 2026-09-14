return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				lemminx = {
					filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
					settings = {
						xml = {
							server = {
								workDir = "~/.cache/lemminx",
							},
							logs = {
								client = true,
							},
							format = {
								enabled = true,
								splitAttributes = false,
								joinCDATALines = false,
								joinCommentLines = false,
								spaceBeforeEmptyCloseTag = true,
							},
						},
					},
				},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				xml = { "xmlformatter" },
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"lemminx",
				"xmlformatter",
			})
		end,
	},
}
