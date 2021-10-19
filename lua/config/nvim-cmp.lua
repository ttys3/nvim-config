-- Setup nvim-cmp.
local cmp = require "cmp"

cmp.setup {
	documentation = {
		border = "single",
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
	mapping = {
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
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		-- https://github.com/hrsh7th/nvim-cmp/issues/231
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp" },

		-- For vsnip user.
		-- { name = "vsnip" },

		-- For luasnip user.
		{ name = "luasnip" },

		-- For ultisnips user.
		-- { name = "ultisnips" },

		{ name = "crates" },

		{ name = "cmp_tabnine" },

		{ name = "nvim_lua" },

		-- { name = "omni" },

		{ name = "buffer" },
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
			},
		},
	},
}
