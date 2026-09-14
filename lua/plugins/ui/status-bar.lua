return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.options.globalstatus = true
			opts.options.section_separators = { left = "\u{e0b4}", right = "" }
			opts.options.component_separators = { left = "", right = "" }

			opts.sections.lualine_a = {
				{
					function()
						return "✨Bestie"
					end,
					separator = { left = "\u{e0b6}", right = "\u{e0b4}" },
				},
			}
			opts.sections.lualine_b = {
				{
					"mode",
					separator = { left = "\u{e0b6}", right = "\u{e0b4}" },
					padding = { left = 1, right = 1 },
				},
			}
			opts.sections.lualine_c = {
				{
					"branch",
					icon = "\u{e0a0}",
					padding = { left = 1, right = 1 },
				},
				-- { "filename", icon_enabled = false, path = 4 },
			}
			opts.sections.lualine_x = {
				{
					"lsp_status",
					separator = { left = "\u{e0b6}", right = "\u{e0b4}" },
					padding = { left = 1, right = 1 },
				},
			}
			opts.sections.lualine_y = {
				{
					"location",
					separator = { left = "\u{e0b6}", right = "\u{e0b4}" },
					padding = { left = 1, right = 1 },
				},
			}
			opts.sections.lualine_z = {}
		end,
	},
}
