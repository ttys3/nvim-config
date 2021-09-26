require "utils"

-------------------------------------------------------------------
-- let global vars (let g:xx = xxx)
-------------------------------------------------------------------

Variable.g {
	-- this will save almost 20ms
	python3_host_skip_check = 1,
	python3_host_prog = "/usr/bin/python3",

	-- " enable embeded lua syntax
	-- " see https://github.com/neovim/neovim/pull/14213
	vimsyn_embed = "l",
	mousehide = true, --  "hide when characters are typed

	-- see https://github.com/rust-lang/rust.vim/blob/87c745d8d506fc1eecc1d81df15d5bde1658a2fc/doc/rust.txt#L61
	-- Set this option to enable vim indentation and textwidth settings to
	-- conform to style conventions of the rust standard library (i.e. use 4
	-- spaces for indents and sets 'textwidth' to 99). This option is enabled by default
	rust_recommended_style = false,
}

-------------------------------------------------------------------
-- set global options (set xxx = xxx)
-------------------------------------------------------------------

Option.g {
	fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1",
	encoding = "utf-8", -- "set encoding for text
	--     " enable true colors
	-- " If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
	-- " (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
	-- " Tmux
	-- " Tmux version must >= v2.2
	-- " set your $TERM to "xterm-256color"
	-- " add this line to your .tmux.conf:
	-- " set-option -ga terminal-overrides ",xterm-256color:Tc"
	-- " enable "true color" in the terminal
	termguicolors = true,

	-- " Neovim ignores t_Co and other terminal codes
	-- " see https://github.com/neovim/neovim/wiki/FAQ#colors-arent-displayed-correctly
	-- " set t_Co=256

	-- enable cursorline
	cursorline = true,

	-- for simnalamburt/vim-mundo
	-- enable persistent undo so that undo history persists across vim sessions
	undofile = true,
	cmdheight = 2,
	laststatus = 2,
	--  -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline
	showmode = false,
	-- Set completeopt to have a better completion experience
	completeopt = "menuone,noinsert,noselect",
	-- Avoid showing message extra message when using completion
	shortmess = vim.o.shortmess .. "c",
	-- lua print(vim.bo.list)
	-- E5108: Error executing lua /usr/local/share/nvim/runtime/lua/vim/_meta.lua:94: 'list' is a window option, not a buffer option. See ":help list"
	-- but it is OK: lua print(vim.bo.list)
	-- highlight whitespace
	list = true,

	-- stylua: ignore
	listchars = "tab:│ ,trail:•,extends:❯,precedes:❮",

	-- " The delay is governed by vim's updatetime option,
	-- " default updatetime 4000ms is not good for async update
	updatetime = 100,

	-- set signcolumn to 2 to avoid git gutter sign conflict with linter sign
	signcolumn = "yes:2",

	background = "dark",

	-- base configuration
	timeoutlen = 300, --mapping timeout
	ttimeoutlen = 50, --keycode timeout

	mouse = "a", --"enable mouse
	history = 1000, --number of command lines to remember
	ttyfast = true, -- assume fast terminal connection
	viewoptions = "folds,options,cursor,unix,slash", -- unix/windows compatibility
	hidden = true, -- allow buffer switching without saving
	autoread = true, -- auto reload if file saved externally
	fileformats = "unix,dos,mac", -- add mac to auto-detection of file format line endings
	-- nrformats = "bin,hex"
	showcmd = true,
	showfulltag = true,
	modeline = true,
	modelines = 5,

	shelltemp = false, -- use pipes
	-- whitespace
	backspace = "indent,eol,start", --" allow backspacing everything in insert mode
	autoindent = true, --          " automatically indent to match adjacent lines
	expandtab = true, --" spaces instead of tabs
	smarttab = true, --" use shiftwidth to enter tabs
	tabstop = 4, --" number of spaces per tab for display
	softtabstop = 4, --" number of spaces per tab in insert mode
	shiftwidth = 4, --" number of spaces when indenting
	shiftround = true,
	linebreak = true,
	showbreak = "↪ ",
	wrap = false,

	scrolloff = 1, --always show content after scroll
	scrolljump = 5, --minimum number of lines to scroll
	display = "lastline,msgsep",
	wildmenu = true, --show list for autocomplete
	wildmode = "list:full", -- Command-line completion mode
	wildignorecase = true,

	splitbelow = true,
	splitright = true,

	-- disable sounds
	visualbell = false,

	-- searching
	hlsearch = true, --"highlight searches
	incsearch = true, --"incremental searching
	ignorecase = true, --"ignore case for searching
	smartcase = true, --"do case-sensitive if there's a capital letter

	--  backups
	backup = true,
	backupdir = vim.fn.expand(vim.fn.stdpath "data" .. "/backup"),
	-- no swap files
	swapfile = false,

	-- ui configuration
	showmatch = true, --"automatically highlight matching braces/brackets/etc.
	matchtime = 2, --"tens of a second to show matching parentheses
	number = true,
	lazyredraw = true,
	foldenable = true, --"enable folds by default
	foldmethod = "indent", --"do not use syntax as fdm due to performance issue
	foldlevelstart = 99, --"open all folds by default

	textwidth = 160,
	colorcolumn = "+1", --highlight column after 'textwidth'
}

if vim.fn.exists "$TMUX" then
	vim.go.clipboard = ""
else
	vim.go.clipboard = "unnamed" --   "sync with OS clipboard
end

-- fixupSHELL env in docker (for example: FTerm.nvim depends on SHELL env)
if not os.getenv "SHELL" then
	vim.fn.setenv("SHELL", "sh")
end

if string.match(os.getenv "SHELL" or "bash", "/fish$") then
	-- VIM expects to be run from a POSIX shell.
	vim.go.shell = "sh"
end

if vim.fn.executable "rg" then
	-- " When the --vimgrep flag is given to ripgrep, then the default value for the --color flag changes to 'never'.
	vim.go.grepprg = "rg --no-heading --vimgrep --smart-case --follow"
	vim.go.grepformat = "%f:%l:%c:%m"
end

-- local options
-- https://neovim.io/doc/user/options.html#local-options

-- window options
Option.w {}

-- buffer options
Option.b {}

-------------------------------------------------------------------
-- keybinds
-------------------------------------------------------------------

-- nnoremap { '<leader>hello', function() print("Hello world, from lua") end }

inoremap { "jk", "<Esc>" }
inoremap { "kj", "<Esc>" }
inoremap { "JK", "<Esc>" }
inoremap { "KJ", "<Esc>" }

-- nnoremap {';' ':'}

nnoremap { "<leader>vs", "<C-w>v<C-w>l" }
nnoremap { "<leader>hs", "<C-w>s" }
nnoremap { "<leader>vsa", ":vert sba<cr>" }

-- alt + h j k l
inoremap { "<A-h>", "<Left>" }
inoremap { "<A-j>", "<Down>" }
inoremap { "<A-k>", "<Up>" }
inoremap { "<A-l>", "<Right" }

-- quick navigate between windows
nnoremap { "<C-h>", "<C-w>h" }
nnoremap { "<C-j>", "<C-w>j" }
nnoremap { "<C-k>", "<C-w>k" }
nnoremap { "<C-l>", "<C-w>l" }

-- " quick list/nolist toggle
-- :set list! list?<cr>
nnoremap {
	"<leader>lt",
	function()
		if vim.wo.list then
			vim.wo.list = false
		else
			vim.wo.list = true
		end
	end,
}

-- golang struct tags generate
nnoremap { "<C-f5>", ":%!gomodifytags -all -add-tags toml,json -file %<CR>" }

-- " in visual mode you can select text, type qq and it'll be replaced by the command output
-- " https://vi.stackexchange.com/questions/7388/replace-selection-with-output-of-external-command/17949#17949
vnoremap { "tb", "c<C-R>=system('mdt', @\")<CR><ESC>" }

-- " formatting shortcuts
--   nmap <leader>fef :call Preserve("normal gg=G")<CR>
--   nmap <leader>f$ :call StripTrailingWhitespace()<CR>
vmap { "<leader>s", ":sort<cr>" }

--   " eval vimscript by line or visual selection
--   "nmap <silent> <leader>e :call ExecVimSource(line('.'), line('.'))<CR>
--   "vmap <silent> <leader>e :call ExecVimSource(line('v'), line('.'))<CR>

--   " toggle paste
--   " map <F6> :set invpaste<CR>:set paste?<CR>

--   " remap arrow keys
--   " tab shortcuts
map { "<leader>tn", ":tabnew<CR>" }
map { "<leader>tc", ":tabclose<CR>" }

--   " quick switch buf
nnoremap { "<up>", ":bprev<CR>" }
nnoremap { "<down>", ":bnext<CR>" }

--   " quick switch tab window
nnoremap { "<right>", ":tabnext<CR>" }
nnoremap { "<left>", ":tabprev<CR>" }
noremap { "<leader>1", "1gt", silent = true }
noremap { "<leader>2", "2gt", silent = true }
noremap { "<leader>3", "3gt", silent = true }
noremap { "<leader>4", "4gt", silent = true }
noremap { "<leader>5", "5gt", silent = true }
noremap { "<leader>6", "6gt", silent = true }
noremap { "<leader>7", "7gt", silent = true }
noremap { "<leader>8", "8gt", silent = true }
noremap { "<leader>9", "9gt", silent = true }
noremap { "<leader>0", ":tabo<CR>", silent = true }

--   " smash escape
--   inoremap jk <esc>
--   inoremap kj <esc>

--   " change cursor position in insert mode
inoremap { "<C-h>", "<left>" }
inoremap { "<C-l>", "<right>" }

inoremap { "<C-u>", "<C-g>u<C-u>" }

--   if mapcheck('<space>/') == ''
--     nnoremap <space>/ :vimgrep //gj **/*<left><left><left><left><left><left><left><left>
--   endif

--   " sane regex
nnoremap { "/", "/\\v" }
vnoremap { "/", "/\\v" }
nnoremap { "?", "?\\v" }
vnoremap { "?", "?\\v" }
nnoremap { ":s/", ":s/\\v" }

--   " command-line window
nnoremap { "q:", "q:i" }
nnoremap { "q/", "q/i" }
nnoremap { "q?", "q?i" }

--   " folds
nnoremap { "zr", "zr:echo &foldlevel<cr>" }
nnoremap { "zm", "zm:echo &foldlevel<cr>" }
nnoremap { "zR", "zR:echo &foldlevel<cr>" }
nnoremap { "zM", "zM:echo &foldlevel<cr>" }

--   " screen line scroll
--   " nnoremap <silent> j gj
--   " nnoremap <silent> k gk

--   " auto center
nnoremap { "n", "nzz", silent = true }
nnoremap { "N", "Nzz", silent = true }
nnoremap { "*", "*zz", silent = true }
nnoremap { "#", "#zz", silent = true }
nnoremap { "g*", "g*zz", silent = true }
nnoremap { "g#", "g#zz", silent = true }
nnoremap { "<C-o>", "<C-o>zz", silent = true }
nnoremap { "<C-i>", "<C-i>zz", silent = true }

--   " reselect visual block after indent
vnoremap { "<", "<gv" }
vnoremap { ">", ">gv" }

--   " reselect last paste
--   nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

--   " find current word in quickfix
--   nnoremap <leader>fw :execute "vimgrep ".expand("<cword>")." %"<cr>:copen<cr>
--   " find last search in quickfix
--   nnoremap <leader>fl :execute 'vimgrep /'.@/.'/g %'<cr>:copen<cr>

--   " hide annoying quit message
nnoremap { "<C-c>", "<C-c>:echo<cr>" }

--   " window killer
--   nnoremap {"Q", ":call CloseWindowOrKillBuffer()<cr>"}

--   " general
--   " nnoremap <BS> :set hlsearch! hlsearch?<cr>
--   " better nohl via https://vi.stackexchange.com/a/252
nnoremap { "<BS>", ':let @/=""<cr>' }
--   " Press Space to turn off highlighting and clear any message already displayed.
--   " nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

--   " helpers for profiling
nnoremap { "<leader>DD", ':exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>', silent = true }
nnoremap { "<leader>DP", ':exe ":profile pause"<cr>', silent = true }
nnoremap { "<leader>DC", ':exe ":profile continue"<cr>', silent = true }
nnoremap { "<leader>DQ", ':exe ":profile pause"<cr>:noautocmd qall!<cr>', silent = true }

-- " commands
-- https://github.com/nanotee/nvim-lua-guide#defining-user-commands
-- There is currently no interface to create user commands in Lua. It is planned, though:
-- https://github.com/neovim/neovim/pull/11613
--   command! -bang Q q<bang>
--   command! -bang QA qa<bang>
--   command! -bang Qa qa<bang>
--   " fast copy command line message to system clipboard
-- command! -bang CpMsg redir @+ | 99message | redir END

--   " leave without save
map { "<leader>x", ":qa!<CR>" }
map { "<leader>q", ":q<CR>" }
noremap { "<leader>W", ":w !sudo tee % > /dev/null" }
nnoremap { "<leader>s", ":w<cr>" }
nnoremap { "<leader>w", ":wq<cr>" }
nnoremap { "<leader>wq", ":wq<cr>" }
-- nnoremap { "<leader>ss", ":wq<cr>" }
-- noremap {"<leader><leader>r", ":source ~/.config/nvim/init.lua<cr>"}

Augroup {
	SetupCursor = {
		-- disable cursorline when insert/visual mode
		{
			"InsertLeave,WinEnter",
			"*",
			function()
				vim.go.cursorline = true
			end,
		},
		{
			"InsertEnter,WinLeave",
			"*",
			function()
				vim.go.cursorline = false
			end,
		},
		-- restore-cursor
		{
			"BufReadPost",
			"*",
			function()
				-- :h restore-cursor or :h last-position-jump
				if vim.fn.line "'\"" >= 1 and vim.fn.line "'\"" <= vim.fn.line "$" and vim.bo.ft ~= "commit" then
					vim.cmd 'normal! g`"'
				end
			end,
		},
	},

	SetupTabsListFold = {
		["FileType"] = {
			{
				"css,scss",
				function()
					vim.wo.foldmethod = "marker"
					vim.wo.foldmarker = { "," }
				end,
			},
			{
				"python",
				function()
					vim.wo.foldmethod = "indent"
				end,
			},
			{
				"markdown",
				function()
					vim.wo.list = false
				end,
			},
			{
				"vim",
				function()
					vim.wo.foldmethod = "indent"
					vim.bo.keywordprg = ":help"
				end,
			},
			--   " Gofmt formats Go programs. It uses tabs for indentation and blanks for alignment.
			--   " Alignment assumes that an editor is using a fixed-width font.
			--   " https://golang.org/cmd/gofmt/
			{
				"go",
				function()
					vim.bo.expandtab = false
					vim.bo.tabstop = 4
					vim.bo.softtabstop = 4
					vim.bo.shiftwidth = 4
				end,
			},
			{
				"vim,xml,html,yaml,dockerfile",
				function()
					vim.bo.tabstop = 2
					vim.bo.softtabstop = 2
					vim.bo.shiftwidth = 2
				end,
			},
			{
				"lua",
				function()
					vim.bo.expandtab = false
					vim.bo.tabstop = 2
					vim.bo.softtabstop = 2
					vim.bo.shiftwidth = 2
				end,
			},

			-- " in makefiles, don't expand tabs to spaces, since actual tab characters are
			-- " needed, and have indentation at 8 chars to be sure that all indents are tabs
			{
				"make",
				function()
					vim.bo.textwidth = 0
					vim.bo.expandtab = false
					vim.wo.wrap = false
					vim.bo.softtabstop = 0
					vim.bo.tabstop = 4
					vim.bo.shiftwidth = 4
					-- iunmap <Tab>
					-- https://github.com/nanotee/nvim-lua-guide#defining-mappings
					vim.api.nvim_del_keymap("i", "<Tab>")
				end,
			},
		},
	},
	-- " because global ftplugin will overrule this, we should set in after/ftplugin/ft.vim
	-- for gomod file it is: after/ftplugin/gomod.vim
	-- " see https://neovim.io/doc/user/filetype.html#ftplugin-overrule
	-- " autocmd FileType lisp setlocal commentstring=;;\ %s
	-- " au BufRead,BufNewFile *.el	setlocal commentstring=;;\ %s
	CommentString = {
		["FileType"] = {
			{
				"gomod",
				function()
					vim.bo.commentstring = "// %s"
				end,
			},
			{
				"toml",
				function()
					vim.bo.commentstring = "# %s"
				end,
			},
		},
	},
	MiscFileType = {
		["BufNewFile,BufRead"] = {
			{
				".gitconfig",
				function()
					vim.api.nvim_command "setlocal filetype=dosini"
				end,
			},
			{
				"*.{automount,service,socket,target,timer}",
				function()
					vim.api.nvim_command "setlocal filetype=systemd"
				end,
			},
			{
				"*.hcl",
				function()
					vim.api.nvim_command "setlocal filetype=hcl"
				end,
			},
			{
				"*.nomad",
				function()
					vim.api.nvim_command "setlocal filetype=nomad"
					vim.api.nvim_command "setlocal filetype=hcl"
				end,
			},
			{
				".tf",
				function()
					vim.api.nvim_command "setlocal filetype=terraform"
				end,
			},
		},
	},
	Misc = {
		["TextYankPost"] = {
			{
				"*",
				function()
					-- Highlight on yank
					vim.highlight.on_yank { higroup = "IncSearch", timeout = 150, on_visual = true }
				end,
			},
		},
	},
}

-- file template
vim.api.nvim_command "augroup FileTemplate"
vim.api.nvim_command "autocmd!"
local template_files = vim.fn.glob(vim.fn.stdpath "config" .. "/template/new.*", 0, 1)
for _, tmpl in ipairs(template_files) do
	local ext = vim.fn.fnamemodify(tmpl, ":e")
	vim.api.nvim_command(string.format("autocmd BufNewFile *.%s  0r %s", ext, tmpl))
end
vim.api.nvim_command "augroup END"
