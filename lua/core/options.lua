-- Global options and vim.g. Compatible with Fedora 44+ and macOS 26+.

-- Skip the python provider if python3 is not on PATH (Homebrew vs /usr/bin).
local python3 = vim.fn.exepath("python3")
if python3 ~= "" then
	vim.g.python3_host_skip_check = 1
	vim.g.python3_host_prog = python3
end

-- Embedded Lua syntax in vimscript files
-- https://github.com/neovim/neovim/pull/14213
vim.g.vimsyn_embed = "l"
vim.g.mousehide = true
-- rust.vim recommended indent/textwidth (off: keep our own width)
vim.g.rust_recommended_style = false

vim.o.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
vim.o.encoding = "utf-8"
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.undofile = true
vim.o.cmdheight = 2
vim.o.laststatus = 2
vim.o.showmode = false

-- Builtin completion (Nvim 0.12+ 'autocomplete'; CTRL-Y accepts)
vim.o.autocomplete = true
vim.o.completeopt = "menuone,noselect,popup"
vim.opt.shortmess:append("c")

-- Hover / signature / cmp-less float border
vim.o.winborder = "single"

vim.o.list = true
vim.o.listchars = "tab:│ ,trail:•,extends:❯,precedes:❮"
vim.o.updatetime = 100
vim.o.signcolumn = "yes:2"
vim.o.background = "dark"

vim.o.timeoutlen = 300
vim.o.ttimeoutlen = 50
vim.o.mouse = "a"
vim.o.history = 1000
vim.o.ttyfast = true
vim.o.viewoptions = "folds,options,cursor,unix,slash"
vim.o.hidden = true
vim.o.autoread = true
vim.o.fileformats = "unix,dos,mac"
vim.o.showcmd = true
vim.o.showfulltag = true
vim.o.modeline = true
vim.o.modelines = 5
vim.o.shelltemp = false

vim.o.backspace = "indent,eol,start"
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.linebreak = true
vim.o.showbreak = "↪ "
vim.o.wrap = false

vim.o.scrolloff = 1
vim.o.scrolljump = 5
vim.o.display = "lastline,msgsep"
vim.o.wildmenu = true
vim.o.wildmode = "list:full"
vim.o.wildignorecase = true

vim.o.splitbelow = true
vim.o.splitright = true
vim.o.visualbell = false

vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.backup = true
local backupdir = vim.fn.stdpath("data") .. "/backup"
vim.fn.mkdir(backupdir, "p")
vim.o.backupdir = backupdir
vim.o.swapfile = false

vim.o.showmatch = true
vim.o.matchtime = 2
vim.o.number = true
vim.o.lazyredraw = true
vim.o.foldenable = true
vim.o.foldmethod = "indent"
vim.o.foldlevelstart = 99

vim.o.textwidth = 160
vim.o.colorcolumn = "+1"

-- unnamedplus: Nvim picks pbcopy / wl-clipboard / xclip. Empty under tmux.
if vim.fn.exists("$TMUX") == 1 then
	vim.o.clipboard = ""
else
	vim.o.clipboard = "unnamedplus"
end

-- FTerm.nvim (and others) read $SHELL
if not os.getenv("SHELL") then
	vim.fn.setenv("SHELL", "sh")
end

if string.match(os.getenv("SHELL") or "bash", "/fish$") then
	-- Vim expects a POSIX shell for :! and system()
	vim.o.shell = "sh"
end

if vim.fn.executable("rg") == 1 then
	vim.o.grepprg = "rg --no-heading --vimgrep --smart-case --follow"
	vim.o.grepformat = "%f:%l:%c:%m"
end

-- Experimental Nvim 0.13 UI. Off by default.
-- require("vim._core.ui2").enable()
