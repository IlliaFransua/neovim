return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {
					settings = {
						python = {
							analysis = {
								indexing = true,
								useLibraryCodeForTypes = true,
								autoImportCompletions = true,
								diagnosticMode = "workspace",
								autoSearchPaths = true,
							},
						},
					},
				},
			},
		},
	},
}
