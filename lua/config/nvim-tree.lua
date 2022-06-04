map { "<F4>", ":NvimTreeToggle<CR>" }
nnoremap { "<leader>f", ":NvimTreeToggle<CR>" }
-- NvimTreeOpen and NvimTreeClose are also available if you need them
-- a list of groups can be found at `:help nvim_tree_highlight`
-- vim.cmd [[highlight NvimTreeFolderIcon guifg=#1b95e0]]

-- jump to the main window (startify)
-- :h startify-faq-06
Variable.g {
	nvim_tree_allow_resize = 1, -- 0 by default, will not resize the tree when opening a file
}

-- https://github.com/kyazdani42/nvim-tree.lua#setup
--  Migration guide https://github.com/kyazdani42/nvim-tree.lua/issues/674
require("nvim-tree").setup {
	view = {
		-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		side = "left",
		width = 45, -- 30 by default
	},
	filters = {
		dotfiles = true, -- hide dot files
		custom = { ".git", "node_modules", ".cache", ".idea" }, -- custom hide
	},
	renderer = {
		root_folder_modifier = ":~",
		special_files = {
			["go.mod"] = 1,
			["Cargo.toml"] = 1,
			["README.md"] = 1,
			["Makefile"] = 1,
			["MAKEFILE"] = 1,
			["composer.json"] = 1,
			["package.json"] = 1,
		},
		icons = {
			show = { file = true, folder = true, folder_arrow = true },
		},
		highlight_git = true,
		indent_markers = {
			enable = false,
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
			window_picker = {
				exclude = {
					filetype = {
						"packer",
						"qf",
						"startify",
					},
					buftype = {
						"terminal",
					},
				},
			},
		},
	},
}

-- closes neovim automatically when the tree is the last **WINDOW** in the view
-- https://github.com/kyazdani42/nvim-tree.lua/pull/155/files
-- autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
-- https://neovim.io/doc/dev/api_2autocmd_8c.html#a4bf35800481959bb8583e9593a277eb7
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	nested = true,
	callback = function()
		if vim.fn.winnr "$" == 1 and vim.fn.bufname() == "NvimTree_" .. vim.fn.tabpagenr() then
			vim.api.nvim_command ":silent qa!"
		end
	end,
})
