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
				indent = {
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "╰",
					expander_collapsed = "",
					expander_expanded = "",
				},
				icon = {
					provider = function(icon, node)
						local text, hl
						local mini_icons = require("mini.icons")
						if node.type == "file" then
							text, hl = mini_icons.get("file", node.name)
						elseif node.type == "directory" then
							text, hl = mini_icons.get("directory", node.name)
							if node:is_expanded() then
								text = nil
							end
						end
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
						".env",
					},
					never_show = {
						".git",
					},
				},
				use_libuv_file_watcher = true,
			},
			window = {
				popup = {
					border = "rounded",
				},
				mappings = {
					["S"] = "create_spring_module",
					["m"] = "java_move_with_refactor",
				},
			},
			commands = {
				create_spring_module = function(state)
					require("custom.spring-generator").create_module(state)
				end,

				java_move_with_refactor = function(state)
					local node = state.tree:get_node()
					if node.type ~= "file" then
						vim.notify("Работает только с файлами", vim.log.levels.WARN)
						return
					end

					-- открываем файл в буфере (JdtMoveFile работает на текущем буфере)
					vim.cmd("edit " .. vim.fn.fnameescape(node.path))

					-- небольшая задержка чтоб jdtls успел подключиться к буферу
					vim.defer_fn(function()
						vim.cmd("JdtMoveFile")
					end, 200)
				end,
			},
		},
	},
}
