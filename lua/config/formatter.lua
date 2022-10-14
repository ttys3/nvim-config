vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.lua FormatWrite
  autocmd BufWritePost *.{hcl,nomad,terraform,tf} FormatWrite
  autocmd BufWritePost *.{yaml,yml} FormatWrite
  autocmd BufWritePost *.{proto,proto3,proto2} FormatWrite
augroup END
]],
	true
)

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
		nomad = {
			function()
				return {
					exe = "hclfmt",
					args = { "--" },
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
