--
-- bootstrap lazy.nvim, then load core + plugin specs
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
		}, true, {})
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- log file: stdpath("log") on 0.12; 0.13 moves this under state/logs
local lsp_debug = os.getenv("LSP_DEBUG")
if lsp_debug then
	vim.lsp.set_log_level("trace")
	require("vim.lsp.log").set_format_func(vim.inspect)
end

require("core.options")
require("core.keymaps")
require("core.autocmds")

require("lazy").setup({
	spec = { { import = "plugins" } },
	defaults = { lazy = false },
	change_detection = { notify = false },
	ui = { border = "single" },
})
