Option = require "utils.option"
Variable = require "utils.variable"
Keymap = require "utils.keymap"
Agrp = require "utils.agrp"
Augroup = Agrp.set
--print ("fuck require utils.agrp and set global Augroup.type=" .. type(Augroup) .. ', my_name=' .. Agrp.my_name)

map = vim.keymap.map
noremap = vim.keymap.noremap
nmap = vim.keymap.nmap
nnoremap = vim.keymap.nnoremap
vmap = vim.keymap.vmap
vnoremap = vim.keymap.vnoremap
xmap = vim.keymap.xmap
xnoremap = vim.keymap.xnoremap
imap = vim.keymap.imap
inoremap = vim.keymap.inoremap

function _G.dump(...)
	local objects = vim.tbl_map(vim.inspect, { ... })
	print(unpack(objects))
end

function _G.log_to_file(tag, ...)
	tag = tag or "-"
	local objects = vim.tbl_map(vim.inspect, { ... })
	local obj_str = unpack(objects) or ""
	local file = assert(io.open("/tmp/nvim.log", "a"))
	local prefix = tag .. " | " .. os.date "%Y-%m-%dT%H:%M:%S"
	file:write(prefix .. "----------------------------------------------------->" .. "\n")
	file:write(obj_str .. "\n")
	file:write(prefix .. "<-----------------------------------------------------" .. "\n")
	file:close()
end
