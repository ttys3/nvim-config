return {
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			"jbyuki/one-small-step-for-vimkind",
			"leoluz/nvim-dap-go",
		},
		config = function()
			-- .vscode/launch.json is read on demand (:help dap-providers)
			require("dap-go").setup()

			require("nvim-dap-virtual-text").setup({
				commented = true,
			})

			require("dap.lua").setup()

			local dap, dapui = require("dap"), require("dapui")

			dap.set_log_level("TRACE")
			dapui.setup({})

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- DAP signs are not diagnostic signs (sign_define is fine here)
			vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

			vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint)
			vim.keymap.set("n", "<F5>", require("dap").continue)
			vim.keymap.set("n", "<F9>", require("dap").step_over)
			vim.keymap.set("n", "<F10>", require("dap").step_into)
			vim.keymap.set("n", "<F12>", require("dap").step_out)
			vim.keymap.set("n", "<F6>", require("dap").run_to_cursor)
			vim.keymap.set("n", "<leader>du", require("dapui").toggle)
			vim.keymap.set("n", "<leader>dt", require("dap-go").debug_test)
			vim.keymap.set("n", "<leader>dl", require("dap-go").debug_last_test)
		end,
	},
}
