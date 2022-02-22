require("lint").linters_by_ft = {
	markdown = { "vale" },
	sh = { "shellcheck" },
	go = { "golangcilint" },
	dockerfile = { "hadolint" },
}
-- see https://github.com/dense-analysis/ale/blob/5b1044e2ade71fee4a59f94faa108d99b4e61fb2/autoload/ale/events.vim#L102
Augroup {
	NvimLint = {
		{
			"BufEnter,BufRead",
			"*",
			function()
				vim.defer_fn(function()
					require("lint").try_lint()
				end, 300)
			end,
		},
		{
			"BufWritePost",
			"*",
			function()
				require("lint").try_lint()
			end,
		},
		-- InsertLeave or TextChanged
		-- {
		-- 	"InsertChange,TextChanged,TextChangedI",
		-- 	"*",
		-- 	function()
		-- 		vim.defer_fn(function()
		-- 			require("lint").try_lint()
		-- 		end, 300)
		-- 	end,
		-- },
	},
}
