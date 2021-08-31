Variable.g {
	-- do not close the preview tab when switching to other buffers
	mkdp_auto_close = false,
	mkdp_preview_options = {
		maid = {
			theme = "neutral",
			-- theme = "dark",
		},
	},
}
nmap { "<leader>md", "<Plug>MarkdownPreview" }
nmap { "<M-s>", "<Plug>MarkdownPreviewStop" }
nmap { "<leader>mt", "<Plug>MarkdownPreviewToggle" }
