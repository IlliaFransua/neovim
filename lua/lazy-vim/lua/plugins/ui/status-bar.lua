return {
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local mode_icons = {
				NORMAL = "🏠 ",
				INSERT = "✍️ ",
				VISUAL = "👁️ ",
				["V-LINE"] = "📏 ",
				["V-BLOCK"] = "🧱 ",
				COMMAND = "⚙️ ",
				REPLACE = "🔄 ",
				TERMINAL = "💻 ",
				["O-PENDING"] = "⏳ ",
				SELECT = "🔎 ",
			}

			opts.sections.lualine_a = {
				{
					"mode",
					fmt = function(res)
						return (mode_icons[res] or "") .. res
					end,
				},
			}
			opts.sections.lualine_b = { { "branch", icon = "" } }
			opts.sections.lualine_x = {}
			opts.sections.lualine_y = {
				{ "location", padding = { left = 0, right = 1 } },
			}
			opts.sections.lualine_z = {}
		end,
	},
}
