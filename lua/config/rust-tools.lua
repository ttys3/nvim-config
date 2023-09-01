local get_lldb_paths = function()
	-- you need install CodeLLDB vscode extension and then update this path
	-- see https://github.com/simrat39/rust-tools.nvim/wiki/Debugging
	-- ~/.vscode/extensions/vadimcn.vscode-lldb-1.9.2
	local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb"
	local this_os = vim.loop.os_uname().sysname

	-- The path in windows is different
	if this_os:find "Windows" then
		codelldb_path = extension_path .. "adapter\\codelldb.exe"
		liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
	else
		-- The liblldb extension is .so for linux and .dylib for macOS
		liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
	end
	return codelldb_path, liblldb_path
end

local codelldb_path, liblldb_path = get_lldb_paths()

local rt = require "rust-tools"

-- https://github.com/simrat39/rust-tools.nvim#setup
-- https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
	tools = { -- rust-tools options
		-- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
		reload_workspace_from_cargo_toml = true,

		-- automatically set inlay hints (type hints)
		-- There is an issue due to which the hints are not applied on the first
		-- opened file. For now, write to the file to trigger a reapplication of
		-- the hints or just run :RustSetInlayHints.
		-- default: true
		autoSetHints = true,

		runnables = {
			-- whether to use telescope for selection menu or not
			-- default: true
			use_telescope = true,

			-- rest of the opts are forwarded to telescope
		},

		inlay_hints = {
			-- wheter to show parameter hints with the inlay hints or not
			-- default: true
			show_parameter_hints = true,

			-- prefix for parameter hints
			-- default: "<-"
			parameter_hints_prefix = "<-",

			-- prefix for all the other hints (type, chaining)
			-- default: "=>"
			other_hints_prefix = "=>",

			-- whether to align to the lenght of the longest line in the file
			max_len_align = false,

			-- padding from the left if max_len_align is true
			max_len_align_padding = 1,

			-- whether to align to the extreme right or not
			right_align = false,

			-- padding from the right if right_align is true
			right_align_padding = 7,
		},

		hover_actions = {
			-- the border that is used for the hover window
			-- see vim.api.nvim_open_win()
			border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			},

			-- whether the hover action window gets automatically focused
			-- default: false
			auto_focus = true,
		},
	},

	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
	server = {
		-- standalone file support
		-- setting it to false may improve startup time
		standalone = true,
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<leader>a", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>aa", rt.code_action_group.code_action_group, { buffer = bufnr })
		end,

		settings = {
			-- https://rust-analyzer.github.io/manual.html#configuration
			-- https://rust-analyzer.github.io/manual.html#nvim-lsp
			["rust-analyzer"] = {
				assist = {
					importGranularity = "module",
					importPrefix = "by_self",
				},
				cargo = {
					loadOutDirsFromCheck = true,
					allFeatures = true,
				},
				-- rust-analyzer.procMacro.enable
				procMacro = {
					enable = true,
				},
				lruCapacity = 1024,
				-- rust-analyzer.checkOnSave.command": "clippy"
				checkOnSave = {
					enable = true,
					-- default: `cargo check`
					command = "clippy",
				},
				inlayHints = {
					lifetimeElisionHints = {
						enable = true,
						useParameterNames = true,
					},
				},
			},
		},
	}, -- rust-analyer options

	-- debugging stuff
	-- see https://github.com/simrat39/rust-tools.nvim/wiki/Debugging
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
}

rt.setup(opts)
