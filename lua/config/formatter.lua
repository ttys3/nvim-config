vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true }),
	pattern = { "*.lua", "*.{hcl,nomad,terraform,tf}", "*.{yaml,yml}", "*.{proto,proto3,proto2}" },
	callback = function(opts)
		vim.api.nvim_command "FormatWrite"
	end,
})

require("formatter").setup {
	-- Enable or disable logging
	logging = false,
	-- Set the log level
	log_level = vim.log.levels.TRACE,
	filetype = {
		javascript = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
					stdin = true,
				}
			end,
		},
		rust = {
			-- Rustfmt
			function()
				return {
					exe = "rustfmt",
					args = { "--emit=stdout" },
					stdin = true,
				}
			end,
		},
		lua = {
			-- stylua
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
		-- .nomad.hcl
		nomad = {
			function()
				return {
					exe = "nomad",
					args = { "fmt", "-check", "-" },
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
						-- https://clang.llvm.org/docs/ClangFormatStyleOptions.html
						-- be aware that we need ensure double qouted to prevent shell parse `{}`
						'"{ IndentWidth: 4, BasedOnStyle: google, AlignConsecutiveAssignments: true,  AlignConsecutiveDeclarations: true, ColumnLimit: 160 }"',
					},
					stdin = true,
				}
			end,
		},
		-- yaml = {
		-- 	function()
		-- 		return {
		-- 			exe = "yamlfmt",
		-- 			stdin = true,
		-- 		}
		-- 	end,
		-- },
	},
}
