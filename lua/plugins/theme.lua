return {
	{
		"f-person/auto-dark-mode.nvim",
		lazy = false,
		priority = 999,
		opts = {
			update_interval = 3000,
			set_dark_mode = function()
				vim.o.background = "dark"
				-- vim.g.everforest_background = "hard"
				vim.cmd.colorscheme("everforest")
				-- vim.cmd.colorscheme("catppuccin-frappe")
			end,
			set_light_mode = function()
				vim.o.background = "light"
				-- vim.g.everforest_background = "hard"
				-- vim.cmd.colorscheme("everforest")
				-- vim.o.background = "dark"
				-- vim.g.everforest_background = "hard"
				vim.cmd.colorscheme("everforest")
				-- vim.cmd.colorscheme("catppuccin-latte")
			end,
		},
	},

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "everforest", -- tokyonight-moon, catppuccin
		},
	},

	-- everforest
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.everforest_enable_italic = true
			vim.cmd.colorscheme("everforest")
		end,
	},

	-- tokyonight
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = true,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},

	-- catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			lsp_styles = {
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			-- integrations = {
			-- 	aerial = true,
			-- 	alpha = true,
			-- 	cmp = true,
			-- 	dashboard = true,
			-- 	flash = true,
			-- 	fzf = true,
			-- 	grug_far = true,
			-- 	gitsigns = true,
			-- 	headlines = true,
			-- 	illuminate = true,
			-- 	indent_blankline = { enabled = true },
			-- 	leap = true,
			-- 	lsp_trouble = true,
			-- 	mason = true,
			-- 	mini = true,
			-- 	navic = { enabled = true, custom_bg = "lualine" },
			-- 	neotest = true,
			-- 	neotree = true,
			-- 	noice = true,
			-- 	notify = true,
			-- 	snacks = true,
			-- 	telescope = true,
			-- 	treesitter_context = true,
			-- 	which_key = true,
			-- },
		},
		specs = {
			{
				"akinsho/bufferline.nvim",
				optional = true,
				opts = function(_, opts)
					if (vim.g.colors_name or ""):find("catppuccin") then
						opts.highlights = require("catppuccin.special.bufferline").get_theme()
					end
				end,
			},
		},
	},
}
