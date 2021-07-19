require("nvim-blamer").setup {
	enable = true,
	prefix = " ☣  ",
	format = "%committer | %committer-time-human | %summary",
}
Augroup {
	NvimBlamer = {
		{
			"CursorHold",
			"*",
			function()
				require("nvim-blamer").show()
			end,
		},
		{
			"CursorMoved,CursorMovedI",
			"*",
			function()
				require("nvim-blamer").clear()
			end,
		},
	},
}
