return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function(plugin)
			if vim.fn.executable("pnpm") == 1 then
				vim.system({ "pnpm", "install" }, { cwd = plugin.dir .. "/app" }):wait()
			else
				vim.fn["mkdp#util#install"]()
			end
		end,
		config = function()
			require("config.markdown-preview")
		end,
	},
	{
		"plasticboy/vim-markdown",
		config = function()
			require("config.vim-markdown")
		end,
	},
}
