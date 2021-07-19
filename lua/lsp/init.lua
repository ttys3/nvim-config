#!/usr/bin/env lua
local vim = vim
local lsp = vim.lsp

local M = {}

M.set_lsp_omnifunc = function()
	vim.api.nvim_command "setlocal omnifunc=v:lua.vim.lsp.omnifunc"
end

M.formatting_sync = function()
	vim.lsp.buf.formatting_sync(nil, 1000)
end

-- https://www.reddit.com/r/neovim/comments/l00zzb/improve_style_of_builtin_lsp_diagnostic_messages/gjt2hek/
-- https://github.com/glepnir/lspsaga.nvim/blob/cb0e35d2e594ff7a9c408d2e382945d56336c040/lua/lspsaga/diagnostic.lua#L202
M.setup_diagnostic_sign = function()
	local group = {
		err_group = {
			highlight = "LspDiagnosticsSignError",
			sign = "❌",
		},
		warn_group = {
			highlight = "LspDiagnosticsSignWarning",
			sign = "⚠️ ",
		},
		hint_group = {
			highlight = "LspDiagnosticsSignHint",
			sign = "💡",
		},
		infor_group = {
			highlight = "LspDiagnosticsSignInformation",
			sign = "ℹ️ ",
		},
	}

	for _, g in pairs(group) do
		vim.fn.sign_define(g.highlight, { text = g.sign, texthl = g.highlight, linehl = "", numhl = "" })
	end
end

M.fix_imports = function()
	local params = lsp.util.make_range_params()
	params.context = {
		diagnostics = {},
		only = { "source.organizeImports" },
	}

	local responses = lsp.buf_request_sync(vim.fn.bufnr(), "textDocument/codeAction", params)

	if not responses or vim.tbl_isempty(responses) then
		return
	end

	for _, response in pairs(responses) do
		for _, result in pairs(response.result or {}) do
			if result.edit then
				lsp.util.apply_workspace_edit(result.edit)
			end
		end
	end
end

return M
