Variable.g {
	-- do not close the preview tab when switching to other buffers
	mkdp_auto_close = 0,
}
nmap { "<leader>md", "<Plug>MarkdownPreview" }
nmap { "<M-s>", "<Plug>MarkdownPreviewStop" }
nmap { "<leader>mt", "<Plug>MarkdownPreviewToggle" }
