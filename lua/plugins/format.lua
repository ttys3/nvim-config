return {
	{
		"mhartington/formatter.nvim",
		config = function()
			require("config.formatter")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("config.nvim-lint")
		end,
	},
}
