local M = {}

function M.setup_diagnostic_sign()
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "❌",
				[vim.diagnostic.severity.WARN] = "⚠️",
				[vim.diagnostic.severity.HINT] = "💡",
				[vim.diagnostic.severity.INFO] = "ℹ️",
			},
		},
	})
end

M.icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
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

function M.setup_item_kind_icons()
	for i, name in ipairs(kind_order) do
		local symbol = M.icons[name]
		vim.lsp.protocol.CompletionItemKind[i] = symbol and (symbol .. " " .. name) or name
	end
end

return M
