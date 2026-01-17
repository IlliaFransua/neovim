return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"nvim-mini/mini.icons",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
			{ "<leader>E", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
			{ "<leader>fe", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
			{ "<leader>fE", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		},
		opts = {
			default_component_configs = {
				icon = {
					provider = function(icon, node) -- setup a custom icon provider
						local text, hl
						local mini_icons = require("mini.icons")
						if node.type == "file" then -- if it's a file, set the text/hl
							text, hl = mini_icons.get("file", node.name)
						elseif node.type == "directory" then -- get directory icons
							text, hl = mini_icons.get("directory", node.name)
							-- only set the icon text if it is not expanded
							if node:is_expanded() then
								text = nil
							end
						end

						-- set the icon text/highlight only if it exists
						if text then
							icon.text = text
						end
						if hl then
							icon.highlight = hl
						end
					end,
				},
				kind_icon = {
					provider = function(icon, node)
						local mini_icons = require("mini.icons")
						icon.text, icon.highlight = mini_icons.get("lsp", node.extra.kind.name)
					end,
				},
			},
			hide_root_node = false,
			filesystem = {
				group_empty_dirs = true,
				scan_mode = "deep",
				follow_current_file = {
					enabled = true,
				},
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_hidden = true,

					always_show = {
						".gitignore",
						".env.example",
						".editorconfig",
						".nvimrc",
						".prettierrc",
						".eslintrc",
					},

					never_show = {
						".git",
					},
				},
				use_libuv_file_watcher = true,
			},
		},
	},
}
