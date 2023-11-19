require("nvim-treesitter.configs").setup {
	ensure_installed = { "query", "c", "go", "rust", "php", "python", "lua", "json", "toml", "vue", "css", "html", "bash", "hcl" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "markdown" }, -- list of language that will be disabled
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
	},
	query_linter = {
		enable = false,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
	rainbow = {
		enable = false,
	},
}

-- fixup nvim-treesitter cause luochen1990/rainbow not working problem
-- see https://github.com/nvim-treesitter/nvim-treesitter/issues/123#issuecomment-651162962
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/654#issuecomment-727562988
-- https://github.com/luochen1990/rainbow/issues/151#issuecomment-677644891
-- vim.TSHighlighter is removed, please use vim.treesitter.highlighter
-- see https://github.com/neovim/neovim/pull/14145/commits/b5401418768af496ef23b790f700a44b61ad784d
-- deactivate highlight of TSPunctBracket
-- highlight link TSPunctBracket Normal
-- require "nvim-treesitter.highlight"
-- local hlmap = vim.treesitter.highlighter.hl_map
-- hlmap.error = nil
-- hlmap["punctuation.delimiter"] = "Delimiter"
-- hlmap["punctuation.bracket"] = nil

-- nomad
vim.treesitter.language.register("hcl", "nomad") -- the nomad filetype will use the hcl parser and queries.
vim.treesitter.language.register("hcl", "tf")
vim.treesitter.language.register("hcl", "terraform")
