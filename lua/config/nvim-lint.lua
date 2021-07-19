require("lint").linters_by_ft = {
	markdown = { "vale" },
	sh = { "shellcheck" },
	go = { "golangcilint" },
}
Augroup {
	NvimLint = {
		{
			"BufWritePost",
			"<buffer>",
			function()
				require("lint").try_lint()
			end,
		},
		{
			"BufEnter",
			"<buffer>",
			function()
				require("lint").try_lint()
			end,
		},
	},
}
