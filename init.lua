--
-- bootstrapping
--

local print_err = vim.api.nvim_err_writeln

local bootstrap = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
				"git",
				"clone",
				"--filter=blob:none",
				"https://github.com/folke/lazy.nvim.git",
				"--branch=stable", -- latest stable release
				lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)
end

bootstrap()

-- space as neovim leader key
vim.g.mapleader = " "

-- log file location: ~/.cache/nvim/lsp.log
local _lsp_debug = os.getenv "LSP_DEBUG" or false
if _lsp_debug then
	vim.lsp.set_log_level "trace"
	require("vim.lsp.log").set_format_func(vim.inspect)
	print [[You can find your log at $HOME/.local/state/nvim/lsp.log]]
end

require "utils"

require "general"

local plugins = require "plugins"
