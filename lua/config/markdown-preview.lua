vim.g.mkdp_auto_close = false
vim.g.mkdp_preview_options = {
	maid = {
		theme = "neutral",
	},
}

vim.keymap.set("n", "<leader>md", "<Plug>MarkdownPreview", { remap = true })
vim.keymap.set("n", "<M-s>", "<Plug>MarkdownPreviewStop", { remap = true })
vim.keymap.set("n", "<leader>mt", "<Plug>MarkdownPreviewToggle", { remap = true })
