return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.sections.lualine_b = { { "branch", icon = "" } }
			opts.sections.lualine_x = {}
			opts.sections.lualine_z = {}
		end,
	},
}
