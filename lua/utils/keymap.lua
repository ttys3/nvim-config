-- https://github.com/tjdevries/astronauta.nvim/raw/master/lua/astronauta/keymap.lua

if vim.fn.has "nvim-0.7" ~= 1 then
  vim.notify("using vim.keymap.set need at least neovim version >= 0.7", "error")
  return
end

local keymap = {}

local make_mapper = function(mode, defaults, opts)
    local args, map_args = {}, {}
    for k, v in pairs(opts) do
        if type(k) == "number" then
            args[k] = v
        else
            map_args[k] = v
        end
    end

    local lhs = opts.lhs or args[1]
    local rhs = opts.rhs or args[2]
    local map_opts = vim.tbl_extend("force", defaults, map_args)

    if type(rhs) == "string" or type(rhs) == "function" then
        -- ok
    else
        error("Unexpected type for rhs:" .. type(rhs))
    end

    if map_opts.buffer == true then
        map_opts.buffer = 0
    end

    vim.keymap.set(mode, lhs, rhs, map_opts)
end

--- Helper function for ":map".
-- mapmode-nvo
function keymap.map(opts)
    return make_mapper({"n", "v", "o"}, {}, opts)
end

--- Helper function for ":noremap"
function keymap.noremap(opts)
    return make_mapper({"n", "v", "o"}, { remap = false }, opts)
end

--- Helper function for ":nmap".
---
--- <pre>
---   keymap.nmap { "lhs", function() print("real lua function") end, silent = true }
--- </pre>
function keymap.nmap(opts)
    return make_mapper("n", {}, opts)
end

--- Helper function for ":nnoremap"
--- <pre>
---   keymap.nmap { "lhs", function() print("real lua function") end, silent = true }
--- </pre>
function keymap.nnoremap(opts)
    return make_mapper("n", { remap = false }, opts)
end

--- Helper function for ":vmap".
function keymap.vmap(opts)
    return make_mapper("v", {}, opts)
end

--- Helper function for ":vnoremap"
function keymap.vnoremap(opts)
    return make_mapper("v", { remap = false }, opts)
end

--- Helper function for ":xmap".
function keymap.xmap(opts)
    return make_mapper("x", {}, opts)
end

--- Helper function for ":xnoremap"
function keymap.xnoremap(opts)
    return make_mapper("x", { remap = false }, opts)
end

--- Helper function for ":smap".
function keymap.smap(opts)
    return make_mapper("s", {}, opts)
end

--- Helper function for ":snoremap"
function keymap.snoremap(opts)
    return make_mapper("s", { remap = false }, opts)
end

--- Helper function for ":omap".
function keymap.omap(opts)
    return make_mapper("o", {}, opts)
end

--- Helper function for ":onoremap"
function keymap.onoremap(opts)
    return make_mapper("o", { remap = false }, opts)
end

--- Helper function for ":imap".
function keymap.imap(opts)
    return make_mapper("i", {}, opts)
end

--- Helper function for ":inoremap"
function keymap.inoremap(opts)
    return make_mapper("i", { remap = false }, opts)
end

--- Helper function for ":lmap".
function keymap.lmap(opts)
    return make_mapper("l", {}, opts)
end

--- Helper function for ":lnoremap"
function keymap.lnoremap(opts)
    return make_mapper("l", { remap = false }, opts)
end

--- Helper function for ":cmap".
function keymap.cmap(opts)
    return make_mapper("c", {}, opts)
end

--- Helper function for ":cnoremap"
function keymap.cnoremap(opts)
    return make_mapper("c", { remap = false }, opts)
end

--- Helper function for ":tmap".
function keymap.tmap(opts)
    return make_mapper("t", {}, opts)
end

--- Helper function for ":tnoremap"
function keymap.tnoremap(opts)
    return make_mapper("t", { remap = false }, opts)
end

-- DO NOT USE `vim.keymap` !!! nvim 0.7.x now has builtin vim.keymap
-- see runtime/lua/vim/keymap.lua and https://github.com/neovim/neovim/pull/16591
-- print("type(vim.keymap)=".. type(vim.keymap))

return keymap
