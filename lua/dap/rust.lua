
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#ccrust-via-lldb-vscode
-- https://github.com/simrat39/rust-tools.nvim/wiki/Debugging

local M = {}

function M.setup()
    local dap = require "dap"
    dap.configurations.rust = {
      {
        -- :lua dump(require'dap'.adapters)
        type = "rt_lldb",
        request = "launch",
        name = "Rust debug",
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        showDisassembly = "never",
        -- program = "${file}",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,

        -- get rust types
        initCommands = function()
            -- Find out where to look for the pretty printer Python module
            local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))
    
            local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
            local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'
    
            local commands = {}
            local file = io.open(commands_file, 'r')
            if file then
            for line in file:lines() do
                table.insert(commands, line)
            end
            file:close()
            end
            table.insert(commands, 1, script_import)
    
            return commands
        end,

      },
    }

  end
  
  return M