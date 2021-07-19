-- https://github.com/delphinus/agrp.nvim/blob/main/lua/agrp.lua

local M = {
    funcs = {},
    my_name = (function()
        local file = debug.getinfo(1, 'S').source
        return "utils." .. file:match'/(%a+)%.lua$'
    end)()
}

local function make_command(events, patterns, ...)
    local args = {...}
    local options, cmd_or_func
    if #args == 2 then
        options = args[1]
        cmd_or_func = args[2]
    else
        options = {}
        cmd_or_func = args[1]
    end
    local opts = ''
    for _, o in ipairs(options) do
        opts = ('%s ++%s'):format(opts, o)
    end
    local command
    if type(cmd_or_func) == 'string' then
        command = cmd_or_func
    else
        table.insert(M.funcs, cmd_or_func)
        command = ([[lua require'%s'.funcs[%d]()]]):format(M.my_name, #M.funcs)
    end
    return ('autocmd %s %s%s %s'):format(events, patterns, opts, command)
end

local function manage_definitions(cmds, definitions)
    for key, definition in pairs(definitions) do
        vim.validate{
            definition = {definition, 'table'},
        }
        if type(key) == 'number' then
            if #definition == 3 or #definition == 4 then
                table.insert(cmds, make_command(unpack(definition)))
            else
                error'each definition should have 3 values (+options (once, nested))'
            end
        else
            for _, d in ipairs(definition) do
                if #d == 2 or #d == 3 then
                    table.insert(cmds, make_command(key, unpack(d)))
                else
                    error'each definition should have 2 values (+options (once, nested))'
                end
            end
        end
    end
end

M.set = function(groups)
    vim.validate{groups = {groups, 'table'}}
    local cmds = {}
    for name, definitions in pairs(groups) do
        vim.validate{
            definitions = {definitions, 'table'},
        }
        if type(name) == 'number' then
            manage_definitions(cmds, definitions)
        else
            table.insert(cmds, 'augroup '..name)
            table.insert(cmds, 'autocmd!')
            manage_definitions(cmds, definitions)
            table.insert(cmds, 'augroup END')
        end
    end
    vim.api.nvim_exec(table.concat(cmds, '\n'), false)
end

return M