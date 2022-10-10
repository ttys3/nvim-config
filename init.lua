--
-- bootstrapping
--
local pluginman_opt = true
local pluginman_repo = "https://github.com/wbthomason/packer.nvim"
local print_err = vim.api.nvim_err_writeln

local bootstrap = function()
	local execute = vim.api.nvim_command
	local fn = vim.fn

	-- opt:   site/pack/packer/opt/packer.nvim
	-- start: site/pack/packer/start/packer.nvim
	local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
	if pluginman_opt then
		install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
	end

	if fn.empty(fn.glob(install_path)) > 0 then
		print("packer.nvim not found in " .. install_path .. ", try install ...")
		fn.system { "git", "clone", pluginman_repo, install_path }
		if pluginman_opt then
			execute "packadd packer.nvim"
		end
		print("packer.nvim installed to " .. install_path)
	end
end

bootstrap()

-- Only required if you have packer in your `opt` pack
if pluginman_opt then
	vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[autocmd BufWritePost general.lua source <afile> | PackerCompile]]
vim.cmd [[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]]

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
