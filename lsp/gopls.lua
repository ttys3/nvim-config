---@type vim.lsp.Config
return {
	settings = {
		gopls = {
			usePlaceholders = true,
			completeUnimported = true,
			gofumpt = true,
			staticcheck = true,
			templateExtensions = {},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			codelenses = {
				generate = false,
				gc_details = true,
				regenerate_cgo = true,
				tidy = true,
				upgrade_dependency = true,
				vendor = false,
			},
		},
	},
}
