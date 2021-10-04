require("feline").setup {
	preset = "default",
	custom_providers = {
		lsp_status = function()
			return #vim.lsp.buf_get_clients() > 0 and require("lsp-status").status() or ""
		end,

		lsp_progress = function()
			return #vim.lsp.buf_get_clients() > 0 and require("lsp").lsp_progress() or ""
		end,
	},
}

local components = require("feline.presets")["default"]

if components.active[1] then
	table.insert(components.active[1], {
		provider = "lsp_client_names",
		left_sep = " ",
	})
	table.insert(components.active[1], {
		provider = "lsp_progress",
		left_sep = " ",
		-- right_sep = ' ',
	})
end
