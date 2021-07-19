Variable.g {
	completion_chain_complete_list = {
		default = {
			{ complete_items = { "lsp", "snippet", "tabnine" } },
			{ mode = "<c-p>" },
			{ mode = "<c-n>" },
		},
	},
	-- " tabnine priority (default: 0)
	-- " Defaults to lowest priority
	completion_tabnine_priority = 0,
	-- " tabnine binary path (default: expand("<sfile>:p:h:h") .. "/binaries/TabNine_Linux")
	-- " completion_tabnine_tabnine_path = ""
	-- " max tabnine completion options(default: 7)
	completion_tabnine_max_num_results = 7,
	-- " sort by tabnine score (default: 0)
	completion_tabnine_sort_by_details = 1,
	-- " max line for tabnine input(default: 1000)
	-- " from current line -1000 ~ +1000 lines is passed as input
	completion_tabnine_max_lines = 1000,

	completion_enable_auto_popup = 1,
	completion_enable_auto_hover = 1,
	completion_enable_auto_signature = 1,
	completion_matching_smart_case = 1,
	completion_trigger_keyword_length = 1, -- default = 1, default value is 80
	-- " auto change sources whenever this completion source has no complete item
	completion_auto_change_source = 1,
	completion_enable_auto_paren = 1,

	-- possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
	completion_enable_snippet = "UltiSnips",
	-- " By default <CR> is used to confirm completion and expand snippets, change it by
	-- " let g:completion_confirm_key = "\<C-y>"
	-- " Make sure to use " " and add escape key \ to avoid parsing issues.
	-- " If the confirm key has a fallback mapping, for example when using the auto pairs plugin, it maps to <CR>.
	-- see site/pack/packer/start/completion-nvim/lua/completion.lua line 260
	completion_confirm_key = "\\<CR>",
}

-- " keep the same as vim-clap, see https://github.com/liuchengxu/vim-clap/pull/52
-- "use <c-j> to switch to previous completion
-- https://github.com/nanotee/nvim-lua-guide#vimapinvim_replace_termcodes
local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
function _G.smart_CN_cj()
	return vim.fn.pumvisible() == 1 and t "<C-n>" or t "<c-j>"
end
inoremap { "<c-j>", "v:lua.smart_CN_cj()", expr = true }
-- "use <c-k> to switch to next completion
function _G.smart_CP_ck()
	return vim.fn.pumvisible() == 1 and t "<C-p>" or t "<c-k>"
end
inoremap { "<c-k>", "v:lua.smart_CP_ck()", expr = true }

function _G.smart_tab()
	return vim.fn.pumvisible() == 1 and t "<C-n>" or t "<Tab>"
end

-- " inoremap <c-n> <Plug>(completion_next_source)
-- " inoremap <c-p> <Plug>(completion_prev_source)

-- " this does not work because default expand trigger is <Tab>
-- " see https://github.com/SirVer/ultisnips#quick-start
-- " let g:UltiSnipsExpandTrigger="<tab>"
-- " maybe using your own trigger functions
-- " see https://github.com/SirVer/ultisnips/blob/c270950492d71bac0317d47d42cd0884eefe6490/doc/UltiSnips.txt#L266
-- " Use <Tab> and <S-Tab> to navigate through popup menu
-- " inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
