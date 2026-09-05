local augroup = function(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
	group = augroup("SetupCursor"),
	callback = function()
		vim.wo.cursorline = true
	end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
	group = "SetupCursor",
	callback = function()
		vim.wo.cursorline = false
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = "SetupCursor",
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount and vim.bo.filetype ~= "commit" then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("ProtectFile"),
	pattern = { "*.rs" },
	callback = function()
		local home = vim.fn.expand("~")
		local protect_dirs = {
			"^" .. home .. "/.rustup/toolchains/",
			"^" .. home .. "/.cargo/git/",
			"^" .. home .. "/.cargo/registry/",
		}
		local path = vim.fn.expand("%:p")
		for _, prefix in ipairs(protect_dirs) do
			if string.match(path, prefix) then
				vim.bo.readonly = true
				vim.bo.modifiable = false
				break
			end
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("RemoveTrailingWhitespace"),
	pattern = { "*" },
	callback = function()
		local patterns = {
			[[%s/\s\+$//e]],
			[[%s/\%u200b\+$//e]],
		}
		local save = vim.fn.winsaveview()
		for _, v in pairs(patterns) do
			vim.cmd("silent! " .. v)
		end
		vim.fn.winrestview(save)
	end,
})

local tabs = augroup("SetupTabsListFold")

vim.api.nvim_create_autocmd("FileType", {
	group = tabs,
	pattern = { "markdown" },
	callback = function()
		vim.wo.list = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = tabs,
	pattern = { "go" },
	callback = function()
		vim.bo.expandtab = false
		vim.bo.tabstop = 4
		vim.bo.softtabstop = 4
		vim.bo.shiftwidth = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = tabs,
	pattern = { "vim", "xml", "html", "yaml", "dockerfile" },
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.softtabstop = 2
		vim.bo.shiftwidth = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = tabs,
	pattern = { "lua" },
	callback = function()
		vim.bo.expandtab = false
		vim.bo.tabstop = 2
		vim.bo.softtabstop = 2
		vim.bo.shiftwidth = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = tabs,
	pattern = { "make" },
	callback = function()
		vim.bo.textwidth = 0
		vim.bo.expandtab = false
		vim.wo.wrap = false
		vim.bo.softtabstop = 0
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
	end,
})

local comments = augroup("CommentString")

vim.api.nvim_create_autocmd("FileType", {
	group = comments,
	pattern = { "gomod" },
	callback = function()
		vim.bo.commentstring = "// %s"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup("FixNomadFileType"),
	pattern = { "*.nomad.hcl", "*.nomad" },
	callback = function()
		vim.bo.filetype = "nomad"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = comments,
	pattern = { "toml", "nomad" },
	callback = function()
		vim.bo.commentstring = "# %s"
	end,
})

local misc = augroup("MiscFileType")

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = misc,
	pattern = { ".gitconfig" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = misc,
	pattern = { "*.{automount,service,socket,target,timer}" },
	callback = function()
		vim.bo.filetype = "systemd"
	end,
})

-- 0.13: vim.hl.hl_op(); 0.12: vim.hl.on_yank()
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("HighlightOnYank"),
	callback = function()
		local opts = { higroup = "IncSearch", timeout = 150, on_visual = true }
		if vim.hl and vim.hl.hl_op then
			vim.hl.hl_op(opts)
		else
			vim.hl.on_yank(opts)
		end
	end,
})

local ft_au_group = augroup("FileTemplate")
local template_files = vim.fn.glob(vim.fn.stdpath("config") .. "/template/new.*", false, true)
for _, tmpl in ipairs(template_files) do
	local ext = vim.fn.fnamemodify(tmpl, ":e")
	vim.api.nvim_create_autocmd("BufNewFile", {
		group = ft_au_group,
		pattern = { "*." .. ext },
		callback = function()
			vim.cmd("0r " .. tmpl)
		end,
	})
end
