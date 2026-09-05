require("telescope").load_extension("fzy_native")

local builtin = require("telescope.builtin")
local map = vim.keymap.set

map("n", "<leader><leader>", builtin.find_files)
map("n", "<leader>g", builtin.live_grep)
map("n", "<leader>t", builtin.lsp_document_symbols)
map("n", "<leader>d", function()
	builtin.diagnostics({ bufnr = 0 })
end)
map("n", "<leader>b", function()
	builtin.buffers({
		ignore_current_buffer = true,
		sort_mru = true,
		layout_strategy = "vertical",
		layout_config = { width = 80 },
	})
end)
map("n", "<leader>fh", builtin.help_tags)

local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		mappings = {
			i = {
				["<C-n>"] = false,
				["<C-p>"] = false,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		find_files = {
			prompt_prefix = "🔍",
		},
	},
	extensions = {
		undo = {
			use_delta = true,
			side_by_side = true,
			vim_diff_opts = { ctxlen = 3 },
			layout_strategy = "vertical",
			layout_config = {
				preview_height = 0.8,
			},
		},
	},
})

require("telescope").load_extension("undo")
map("n", "<leader>u", "<cmd>Telescope undo<cr>")
