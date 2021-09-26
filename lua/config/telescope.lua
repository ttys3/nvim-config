#!/usr/bin/env lua

-- This will load fzy_native and have it override the default file sorter
require("telescope").load_extension "fzy_native"

nnoremap { "<leader><leader>", "<cmd>lua require('telescope.builtin').find_files()<cr>" }
nnoremap { "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>" }
nnoremap { "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>" }
nnoremap { "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>" }
nnoremap { "<leader>a", "<cmd>lua require('telescope.builtin').lsp_code_actions({layout_strategy='cursor',layout_config={width=50, height = 10}})<cr>" }

local actions = require "telescope.actions"
-- Global remapping
------------------------------
require("telescope").setup {
	defaults = {
		mappings = {
			i = {
				-- To disable a keymap, put [map] = false
				-- So, to not map "<C-n>", just put
				["<C-n>"] = false,
				["<C-p>"] = false,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
}
