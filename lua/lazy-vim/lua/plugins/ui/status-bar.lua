return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local mode = {
				"mode",
				fmt = function(str)
					return "✨Bestie " .. str
				end,
			}

			opts.sections.lualine_a = { mode }
		end,
	},
}
