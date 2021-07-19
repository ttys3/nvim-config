require("compe").setup {
	debug = true,
	enabled = true,
	autocomplete = true,
	min_length = 1,
	preselect = "enable",
	throttle_time = 80,
	source_timeout = 200,
	resolve_timeout = 800,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = {
		border = { "", "", "", " ", "", "", "", " " }, -- the border option is the same as `|help nvim_open_win|`
		winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
		max_width = 120,
		min_width = 60,
		max_height = math.floor(vim.o.lines * 0.3),
		min_height = 1,
	},

	source = {
		path = true,
		nvim_lsp = true,
		buffer = true,
		calc = true,
		nvim_lua = true,
		omni = true,
		tags = false,
		vsnip = false,
		ultisnips = true,
		luasnip = false,
		tabnine = {
			max_line = 1000,
			max_num_results = 6,
			priority = 5000,
			-- setting sort to false means compe will leave tabnine to sort the completion items
			sort = false,
			show_prediction_strength = true,
			-- ignore_pattern = '[(]',
			ignore_pattern = "",
		},
	},
}

vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-e>", "compe#close('<C-e>')", { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-f>", "compe#scroll({ 'delta': +4 })", { expr = true, noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-d>", "compe#scroll({ 'delta': -4 })", { expr = true, noremap = true, silent = true })

-- " keep the same as vim-clap, see https://github.com/liuchengxu/vim-clap/pull/52
-- "use <c-j> to switch to previous completion item
-- https://github.com/nanotee/nvim-lua-guide#vimapinvim_replace_termcodes
local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
function _G.smart_CN_cj()
	return vim.fn.pumvisible() == 1 and t "<C-n>" or t "<c-j>"
end

inoremap { "<c-j>", "v:lua.smart_CN_cj()", expr = true }

-- "use <c-k> to switch to next completion item
function _G.smart_CP_ck()
	return vim.fn.pumvisible() == 1 and t "<C-p>" or t "<c-k>"
end

inoremap { "<c-k>", "v:lua.smart_CP_ck()", expr = true }

function _G.smart_tab()
	return vim.fn.pumvisible() == 1 and t "<C-n>" or t "<Tab>"
end
