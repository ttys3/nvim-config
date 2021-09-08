require("feline").setup {
	preset = "default",
}
require("feline.providers").add_provider("lsp_status", function()
	return #vim.lsp.buf_get_clients() > 0 and require("lsp-status").status() or ""
end)
require("feline.providers").add_provider("lsp_progress", function()
	return #vim.lsp.buf_get_clients() > 0 and require("lsp").lsp_progress() or ""
end)
local components = require("feline.presets")["default"].components
if components.left then
	table.insert(components.left.active, {
		provider = "lsp_client_names",
		left_sep = " ",
	})
	table.insert(components.left.active, {
		provider = "lsp_progress",
		left_sep = " ",
		-- right_sep = ' ',
	})
end
