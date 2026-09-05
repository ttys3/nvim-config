return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			require("config.telescope")
		end,
	},
}
