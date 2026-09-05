-- Resolve lua-language-server from PATH (dnf / brew / cargo). Do not hardcode install dirs.
---@type vim.lsp.Config
local cfg = {
	settings = {
		Lua = {
			format = { enable = false },
			runtime = { version = "LuaJIT" },
			diagnostics = {
				globals = { "vim", "describe", "it", "before_each", "after_each" },
			},
			workspace = {
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
}

local bin = vim.fn.exepath("lua-language-server")
if bin ~= "" then
	cfg.cmd = { bin }
end

return cfg
