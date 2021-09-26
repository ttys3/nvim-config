local saga = require "lspsaga"
saga.init_lsp_saga {
	use_saga_diagnostic_sign = false,
	--     error_sign = "❌",
	--     warn_sign = "⚠️ ",
	--     infor_sign = "ℹ️ ",
	--     hint_sign = "💡",
	code_action_keys = {
		quit = "q",
		exec = "<CR>",
	},
	rename_action_keys = {
		quit = "<esc><esc>",
		exec = "<CR>", -- quit can be a table
	},
}
