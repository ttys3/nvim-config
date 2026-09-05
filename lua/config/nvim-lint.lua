require("lint").linters_by_ft = {
	markdown = { "vale" },
	sh = { "shellcheck" },
	go = { "golangcilint" },
	dockerfile = { "hadolint" },
}

local function try_lint()
	local diag = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })
	if diag and #diag > 0 then
		-- Avoid overlaying the same line with both LSP and nvim-lint
		return
	end
	require("lint").try_lint()
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
	group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
	callback = function()
		vim.defer_fn(try_lint, 300)
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = "NvimLint",
	callback = try_lint,
})
