return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.sections.lualine_a = {
				{
					function()
						return "✨Bestie"
					end,
				},
			}

			opts.sections.lualine_b = { { "mode" }, { "branch", icon = "", padding = { left = 0, right = 1 } } }

			opts.sections.lualine_c = {
				{
					"filename",
					icon_enabled = false,
					path = 4,
				},
			}

			opts.sections.lualine_x = {}
			opts.sections.lualine_y = {
				{ "location", padding = { left = 0, right = 1 } },
			}
			opts.sections.lualine_z = {}
		end,
	},
}