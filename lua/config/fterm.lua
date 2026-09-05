require("FTerm").setup({
	dimensions = {
		height = 0.8,
		width = 0.8,
		x = 0.5,
		y = 0.5,
	},
	border = "single",
})

local term = require("FTerm.terminal")

local gitui = term:new():setup({
	cmd = "gitui",
	dimensions = {
		height = 0.9,
		width = 0.9,
	},
})

local function fterm_gitui()
	gitui:toggle()
end

local map = vim.keymap.set
local opts = { silent = true }

map("n", "<A-i>", function()
	require("FTerm").toggle()
end, opts)
map("t", "<A-i>", "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>", opts)
map("n", "<A-j>", fterm_gitui, opts)
map("t", "<A-j>", function()
	vim.cmd("stopinsert")
	fterm_gitui()
end, opts)
