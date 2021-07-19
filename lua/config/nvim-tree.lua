map { "<F4>", ":NvimTreeToggle<CR>" }
nnoremap { "<leader>f", ":NvimTreeToggle<CR>" }
nnoremap { "<leader>r", ":NvimTreeRefresh<CR>" }
nnoremap { "<leader>ff", ":NvimTreeFindFile<CR>" }
-- NvimTreeOpen and NvimTreeClose are also available if you need them
-- a list of groups can be found at `:help nvim_tree_highlight`
vim.cmd [[highlight NvimTreeFolderIcon guibg=#1b95e0]]

-- jump to the main window (startify)
-- :h startify-faq-06
Variable.g {
	nvim_tree_side = "left", -- left by default
	nvim_tree_width = 30, -- 30 by default
	nvim_tree_ignore = { ".git", "node_modules", ".cache", ".idea" }, -- empty by default
	nvim_tree_auto_open = 0, -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
	nvim_tree_auto_close = 1, -- 0 by default, closes the tree when it's the last window
	nvim_tree_quit_on_open = 1, -- 0 by default, closes the tree when you open a file
	nvim_tree_follow = 1, -- 0 by default, this option allows the cursor to be updated when entering a buffer
	nvim_tree_indent_markers = 1, -- 0 by default, this option shows indent markers when folders are open
	nvim_tree_hide_dotfiles = 1, -- 0 by default, this option hides files and folders starting with a dot `.`
	nvim_tree_git_hl = 1, -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
	nvim_tree_root_folder_modifier = ":~", -- This is the default. See :help filename-modifiers for more options
	nvim_tree_tab_open = 1, -- 0 by default, will open the tree when entering a new tab and the tree was previously open
	nvim_tree_allow_resize = 1, -- 0 by default, will not resize the tree when opening a file
	nvim_tree_show_icons = {
		git = 1,
		folders = 1,
		files = 1,
		folder_arrows = 1,
	},
	--If 0, do not show the icons for one of 'git' 'folder' and 'files'
	--1 by default, notice that if 'files' is 1, it will only display
	--if nvim-web-devicons is installed and on your runtimepath
	nvim_tree_special_files = {
		["go.mod"] = 1,
		["Cargo.toml"] = 1,
		["README.md"] = 1,
		["Makefile"] = 1,
		["MAKEFILE"] = 1,
	}, -- List of filenames that gets highlighted with NvimTreeSpecialFile
	nvim_tree_window_picker_exclude = {
		filetype = {
			"packer",
			"qf",
		},
		buftype = {
			"terminal",
		},
	},
}
