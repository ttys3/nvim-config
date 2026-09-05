-- nvim-lspconfig is a data pack (lsp/*.lua). Setup is vim.lsp.config + vim.lsp.enable.
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "rcarriga/nvim-notify" },
		config = function()
			require("lsp").setup_diagnostic_sign()
			require("lsp").setup_item_kind_icons()
			require("lsp.attach")

			vim.lsp.enable({
				"bashls",
				"intelephense",
				"dockerls",
				"gopls",
				"clangd",
				"pyright",
				"lua_ls",
				"ts_ls",
				"denols",
				"vala_ls",
				"vimls",
				"vuels",
				"html",
				"cssls",
				"jsonls",
				"yamlls",
				"tailwindcss",
				"nomadls",
			})
		end,
	},
}
