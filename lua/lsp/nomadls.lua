local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local util = require "lspconfig.util"

configs.nomadls = {
	default_config = {
		cmd = { "nomad-lsp" },
		filetypes = { "nomad" },
		root_dir = util.path.dirname,
	},
	-- on_new_config = function(new_config) end;
	-- on_attach = function(client, bufnr) end;
	docs = {
		description = [[
https://github.com/ttys3/nomad-lsp
Language Server Protocol for Nomad.
]],
		default_config = {
			root_dir = [[root_pattern(".git")]],
		},
	},
}
lspconfig.nomadls.setup({})

-- vim:et ts=2 sw=2
