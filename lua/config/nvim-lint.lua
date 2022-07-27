require("lint").linters_by_ft = {
	markdown = { "vale" },
	sh = { "shellcheck" },
	go = { "golangcilint" },
	dockerfile = { "hadolint" },
}

TryLint = function()
	local diag = vim.diagnostic.get(0, { severity_limit = vim.diagnostic.severity.WARN })
	if diag and type(diag) == "table" and #diag > 0 then
		-- avoid duplicated error and warning overlay on the same line by lsp and nvim-lint both
		return
	end
	require("lint").try_lint()
end

-- see https://github.com/dense-analysis/ale/blob/5b1044e2ade71fee4a59f94faa108d99b4e61fb2/autoload/ale/events.vim#L102
Augroup {
	NvimLint = {
		{
			"BufEnter,BufRead",
			"*",
			function()
				vim.defer_fn(function()
					TryLint()
				end, 300)
			end,
		},
		{
			"BufWritePost",
			"*",
			function()
				TryLint()
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
