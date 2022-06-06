-- Setup nvim-cmp.
-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local luasnip = require "luasnip"

local cmp = require "cmp"

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
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
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
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
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
		{ name = "copilot", group_index = 1 },

		{ name = "cmp_tabnine", group_index = 2 },

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
}
