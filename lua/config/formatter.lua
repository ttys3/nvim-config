vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true }),
	-- Lua / HCL / Nomad / proto: formatter.nvim. YAML/Go/Rust/C/Python/PHP: vim.lsp.buf.format
	pattern = { "*.lua", "*.{hcl,nomad,terraform,tf}", "*.{proto,proto3,proto2}" },
	callback = function()
		vim.cmd("FormatWrite")
	end,
})

require("formatter").setup({
	logging = false,
	log_level = vim.log.levels.TRACE,
	filetype = {
		javascript = {
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
					stdin = true,
				}
			end,
		},
		lua = {
			function()
				return {
					exe = "stylua",
					args = { "--search-parent-directories", "--stdin-filepath", vim.api.nvim_buf_get_name(0), "-" },
					stdin = true,
				}
			end,
		},
		hcl = {
			function()
				return {
					exe = "hclfmt",
					args = { "--" },
					stdin = true,
				}
			end,
		},
		nomad = {
			function()
				return {
					exe = "nomad",
					args = { "fmt", "-" },
					stdin = true,
				}
			end,
		},
		terraform = {
			function()
				return {
					exe = "hclfmt",
					args = { "--" },
					stdin = true,
				}
			end,
		},
		proto = {
			function()
				return {
					exe = "clang-format",
					args = {
						"--style",
						'"{ IndentWidth: 4, BasedOnStyle: google, AlignConsecutiveAssignments: true,  AlignConsecutiveDeclarations: true, ColumnLimit: 160 }"',
					},
					stdin = true,
				}
			end,
		},
	},
})
