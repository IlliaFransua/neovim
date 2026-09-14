return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				sass = { "prettier" },
				less = { "prettier" },
			},
		},
	},
	{
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, {
				-- TypeScript/JavaScript
				"vtsls",
				"prettier",
				"eslint-lsp",
				"js-debug-adapter",
				-- JSON
				"json-lsp",
				-- HTML
				"html-lsp",
				"emmet-ls",
				-- CSS
				"css-lsp",
				-- Angular
				"angular-language-server",
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				vtsls = {},
				eslint = {},
				jsonls = {},
				html = {
					filetypes = { "html", "htmlangular" },
				},
				cssls = {
					filetypes = { "css", "scss", "less", "sass" },
				},
				emmet_ls = {
					filetypes = {
						"html",
						"htmlangular",
						"css",
						"scss",
						"sass",
						"less",
						"typescriptreact",
						"javascriptreact",
					},
				},
				angularls = {
					filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, {
					"typescript",
					"tsx",
					"html",
					"css",
					"scss",
					"angular",
				})
			end
			opts.highlight = opts.highlight or {}
			opts.highlight.enable = true
		end,
	},
}
