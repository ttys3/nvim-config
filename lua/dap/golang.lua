#!/usr/bin/env lua

local M = {}

function M.init()
	local dap = require("dap")
	dap.adapters.go = function(callback, config)
		local handle
		local port = 38697

		handle = vim.uv.spawn("dlv", {
			args = { "dap", "-l", "127.0.0.1:" .. port },
			detached = true,
		}, function(code)
			if handle then
				handle:close()
			end
			print("Delve exited with exit code: " .. tostring(code))
		end)

		vim.defer_fn(function()
			dap.repl.open()
			callback({ type = "server", host = "127.0.0.1", port = port })
		end, 500)
	end

	dap.configurations.go = {
		{
			type = "go",
			name = "Debug",
			request = "launch",
			program = "${file}",
		},
	}
end

return M
