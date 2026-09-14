return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				sql = { "sql_formatter" },
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				"sql-formatter",
			})
		end,
	},
}
