require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })

vim.keymap.set("n", "s", function()
	require("hop").hint_char2()
end)
vim.keymap.set("n", "S", function()
	require("hop").hint_patterns()
end)
