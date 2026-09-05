return {
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.gitsigns")
		end,
	},

	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"ruifm/gitlinker.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitlinker").setup({
				callbacks = {
					["gitlab.gnome.org"] = require("gitlinker.hosts").get_gitlab_type_url,
					["code.pterclub.com"] = require("gitlinker.hosts").get_gitea_type_url,
				},
				opts = {
					action_callback = require("gitlinker.actions").open_in_browser,
					print_url = true,
				},
				mappings = "<leader>gy",
			})
		end,
	},
}
