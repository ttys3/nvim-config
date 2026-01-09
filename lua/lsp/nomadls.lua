-- Custom nomadls configuration for Neovim 0.11+
-- https://github.com/ttys3/nomad-lsp

vim.lsp.config('nomadls', {
	cmd = { "nomad-lsp" },
	filetypes = { "nomad" },
	root_markers = { ".git" },
})

-- vim:et ts=2 sw=2
