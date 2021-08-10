require("lint").linters_by_ft = {
	markdown = { "vale" },
	sh = { "shellcheck" },
	go = { "golangcilint" },
	dockerfile = { "hadolint" },
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
		-- InsertLeave or TextChanged
		{
			"InsertLeave",
			"*",
			function()
				require("lint").try_lint()
			end,
		},
	},
}
