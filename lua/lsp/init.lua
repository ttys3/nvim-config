#!/usr/bin/env lua
local vim = vim
local lsp = vim.lsp

local M = {}

M.set_lsp_omnifunc = function()
	vim.api.nvim_command "setlocal omnifunc=v:lua.vim.lsp.omnifunc"
end

M.format = function(opts)
	vim.lsp.buf.format(opts)
end

-- https://www.reddit.com/r/neovim/comments/l00zzb/improve_style_of_builtin_lsp_diagnostic_messages/gjt2hek/
-- https://github.com/glepnir/lspsaga.nvim/blob/cb0e35d2e594ff7a9c408d2e382945d56336c040/lua/lspsaga/diagnostic.lua#L202
M.setup_diagnostic_sign = function()
	local group = {
		err_group = {
			highlight = "DiagnosticSignError",
			sign = "❌",
		},
		warn_group = {
			highlight = "DiagnosticSignWarning",
			sign = "⚠️ ",
		},
		hint_group = {
			highlight = "DiagnosticSignHint",
			sign = "💡",
		},
		infor_group = {
			highlight = "DiagnosticSignInformation",
			sign = "ℹ️ ",
		},
	}

	for _, g in pairs(group) do
		vim.fn.sign_define(g.highlight, { text = g.sign, texthl = g.highlight, linehl = "", numhl = "" })
	end
end

-- code from https://github.com/elianiva/dotfiles/blob/997703ea7cf3ebaf0bc1252b47b8c329929bca5e/nvim/lua/modules/statusline.lua#L134-L145
M.lsp_progress = function()
	local lsp = vim.lsp.util.get_progress_messages()[1]
	if lsp then
		local name = lsp.name or ""
		local msg = lsp.message or ""
		local percentage = lsp.percentage or 0
		local title = lsp.title or ""
		return string.format(" %%<%s: %s %s (%s%%%%) ", name, title, msg, percentage)
	end

	return ""
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

-- replace https://github.com/onsails/lspkind-nvim/blob/master/lua/lspkind/init.lua
-- code from wiki https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#completion-kinds
M.icons = {
	-- if you change or add symbol here
	-- replace corresponding line in readme
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "ﰠ",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "塞",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "פּ",
	Event = "",
	Operator = "",
	TypeParameter = "",

	-- Class = " ",
	-- Color = " ",
	-- Constant = " ",
	-- Constructor = " ",
	-- Enum = "了 ",
	-- EnumMember = " ",
	-- Field = " ",
	-- File = " ",
	-- Folder = " ",
	-- Function = " ",
	-- Interface = "ﰮ ",
	-- Keyword = " ",
	-- Method = "ƒ ",
	-- Module = " ",
	-- Property = " ",
	-- Snippet = "﬌ ",
	-- Struct = " ",
	-- Text = " ",
	-- Unit = " ",
	-- Value = " ",
	-- Variable = " ",
}

local kind_order = {
	"Text",
	"Method",
	"Function",
	"Constructor",
	"Field",
	"Variable",
	"Class",
	"Interface",
	"Module",
	"Property",
	"Unit",
	"Value",
	"Enum",
	"Keyword",
	"Snippet",
	"Color",
	"File",
	"Reference",
	"Folder",
	"EnumMember",
	"Constant",
	"Struct",
	"Event",
	"Operator",
	"TypeParameter",
}
local kind_len = 25

function M.setup_item_kind_icons(with_text)
	local symbols = {}
	local len = kind_len
	if with_text then
		for i = 1, len do
			local name = kind_order[i]
			local symbol = M.icons[name]
			symbol = symbol and (symbol .. " ") or ""
			symbols[i] = string.format("%s%s", symbol, name)
		end
	else
		for i = 1, len do
			local name = kind_order[i]
			symbols[i] = M.icons[name]
		end
	end

	for k, v in pairs(symbols) do
		vim.lsp.protocol.CompletionItemKind[k] = v
	end
end

-- https://github.com/onsails/lspkind-nvim/blob/521e4f9217d9bcc388daf184be8b168233e8aeed/lua/lspkind/init.lua#L130
function M.cmp_format(opts)
	if opts == nil then
		opts = {}
	end

	return function(entry, vim_item)
		local symbol = M.icons[vim_item.kind]
		if opts.with_text then
			symbol = symbol and (symbol .. " ") or ""
			vim_item.kind = string.format("%s%s", symbol, vim_item.kind)
		else
			return symbol
		end

		if opts.menu ~= nil then
			vim_item.menu = opts.menu[entry.source.name]
		end

		if opts.maxwidth ~= nil then
			vim_item.abbr = string.sub(vim_item.abbr, 1, opts.maxwidth)
		end

		return vim_item
	end
end

function M.setup_lsp_doc_border(border)
	-- https://www.reddit.com/r/neovim/comments/q3evdt/adding_tailwind_css_intellisense_into_neovim/hfs1htx/
	-- Border can be none, single, double or shadow. https://neovim.io/doc/user/api.html#nvim_open_win()
	border = border or "single"

	-- see runtime/lua/vim/lsp.lua lsp._request_name_to_capability
	local request_name_to_caps = {
		["textDocument/hover"] = "hover",
		["textDocument/signatureHelp"] = "signature_help",
		["textDocument/documentHighlight"] = "document_highlight",
	}

	for k, v in pairs(request_name_to_caps) do
		vim.lsp.handlers[k] = vim.lsp.with(vim.lsp.handlers[v], { border = border })
	end
end

return M
