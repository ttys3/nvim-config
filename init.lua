--
-- bootstrapping
--
local pluginman_opt = true
local pluginman_repo = "https://github.com/wbthomason/packer.nvim"
local print_err = vim.api.nvim_err_writeln

-- interal replacement
-- add the following to init.lua to tell nvim not source the default filetype.vim
vim.g.did_load_filetypes = 1

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
-- vim.lsp.set_log_level("debug")

require "utils"

require "general"

local plugins = require "plugins"
