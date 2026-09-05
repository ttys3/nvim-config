return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				tools = {
					hover_actions = {
						auto_focus = true,
					},
				},
				server = {
					on_attach = function(_, bufnr)
						vim.keymap.set("n", "<leader>a", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, { buffer = bufnr, desc = "Rust hover actions" })
						vim.keymap.set("n", "<Leader>aa", function()
							vim.cmd.RustLsp("codeAction")
						end, { buffer = bufnr, desc = "Rust code action" })
					end,
					default_settings = {
						["rust-analyzer"] = {
							assist = {
								importGranularity = "module",
								importPrefix = "by_self",
							},
							cargo = {
								loadOutDirsFromCheck = true,
								allFeatures = true,
							},
							procMacro = {
								enable = true,
							},
							checkOnSave = {
								enable = true,
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
				},
				dap = {},
			}
		end,
	},

	{
		"Saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
			local crates = require("crates")
			vim.keymap.set("n", "<leader>vt", crates.toggle)
			vim.keymap.set("n", "<leader>vr", crates.reload)
			vim.keymap.set("n", "<leader>vu", crates.update_crate)
			vim.keymap.set("v", "<leader>vu", crates.update_crates)
			vim.keymap.set("n", "<leader>va", crates.update_all_crates)
			vim.keymap.set("n", "<leader>vU", crates.upgrade_crate)
			vim.keymap.set("v", "<leader>vU", crates.upgrade_crates)
			vim.keymap.set("n", "<leader>vA", crates.upgrade_all_crates)
		end,
	},

	"ttys3/vim-gomodifytags",
	"rhysd/vim-go-impl",
}
