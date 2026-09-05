-- Custom Nomad LSP (not shipped with nvim-lspconfig).
-- https://github.com/ttys3/nomad-lsp
---@type vim.lsp.Config
return {
	cmd = { "nomad-lsp" },
	filetypes = { "nomad" },
	root_markers = { ".git" },
}
