-- Setup nvim-cmp.
-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local cmp = require "cmp"

-- see https://github.com/zbirenbaum/copilot-cmp#tab-completion-configuration-highly-recommended
local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup {
	window = {
		documentation = {
			border = "single",
		},
	},
	snippet = {
		expand = function(args)
			-- For `vsnip` user.
			-- vim.fn["vsnip#anonymous"](args.body)

			-- For `luasnip` user.
			require("luasnip").lsp_expand(args.body)

			-- For `ultisnips` user.
			-- vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		-- item go down and up
		["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
		["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
		["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
		["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
		-- doc scrool
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		-- confirm
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),

		-- https://github.com/hrsh7th/nvim-cmp#what-is-the-pairs-wise-plugin-automatically-supported
		["<CR>"] = cmp.mapping.confirm {
			-- behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			  elseif cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				require("luasnip").expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				require("luasnip").jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	sources = {
		-- https://github.com/hrsh7th/cmp-copilot
		-- https://github.com/zbirenbaum/copilot-cmp
		-- https://github.com/zbirenbaum/copilot.lua
		-- Copilot Source
		{ name = "copilot", group_index = 2 },

		-- { name = "cmp_tabnine", group_index = 2 },

		{ name = "nvim_lsp", group_index = 3 },

		-- For vsnip user.
		-- { name = "vsnip" },

		-- For luasnip user.
		{ name = "luasnip", group_index = 4 },

		{ name = "nvim_lua", group_index = 4 },

		-- For ultisnips user.
		-- { name = "ultisnips" },

		{ name = "crates", group_index = 4 },

		-- { name = "omni" },

		{ name = "buffer", group_index = 9 },
	},
	formatting = {
		format = require("lsp").cmp_format {
			with_text = true,
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				luasnip = "[LuaSnip]",
				ultisnips = "[Ultisnips]",
				crates = "[Crates]",
				cmp_tabnine = "[TabNine]",
				latex_symbols = "[Latex]",
				copilot = "[Copilot]",
			},
		},
	},
	sorting = {
		priority_weight = 2,
		comparators = {
		  require("copilot_cmp.comparators").prioritize,
	
		  -- Below is the default comparitor list and order for nvim-cmp
		  cmp.config.compare.offset,
		  -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
		  cmp.config.compare.exact,
		  cmp.config.compare.score,
		  cmp.config.compare.recently_used,
		  cmp.config.compare.locality,
		  cmp.config.compare.kind,
		  cmp.config.compare.sort_text,
		  cmp.config.compare.length,
		  cmp.config.compare.order,
		},
	},
}
