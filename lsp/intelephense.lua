---@type vim.lsp.Config
return {
	init_options = {
		storagePath = vim.fs.joinpath(vim.fn.stdpath("cache"), "intelephense"),
		globalStoragePath = vim.fs.joinpath(vim.fn.stdpath("cache"), "intelephense-global"),
		licenceKey = os.getenv("INTELEPHENSE_LICENCE_KEY") or "",
	},
	settings = {
		intelephense = {
			files = {
				maxSize = 5000000,
			},
			environment = {
				phpVersion = "7.4.0",
			},
		},
	},
}
