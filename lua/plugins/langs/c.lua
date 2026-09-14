return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers = opts.servers or {}

			local clangd_opts = opts.servers.clangd or {}
			local default_cmd = clangd_opts.cmd or { "clangd" }

			local extra_flags = {
				"--background-index",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--header-insertion-decorators",
				"--completion-style=detailed",
			}

			for _, flag in ipairs(extra_flags) do
				if not vim.tbl_contains(default_cmd, flag) then
					table.insert(default_cmd, flag)
				end
			end

			clangd_opts.cmd = default_cmd
			opts.servers.clangd = clangd_opts
		end,
	},
}
