-- Exclude proto: clangd include errors on .proto files.
---@type vim.lsp.Config
return {
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	init_options = {
		clangdFileStatus = true,
	},
}
