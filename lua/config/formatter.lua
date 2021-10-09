vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.lua FormatWrite
  autocmd BufWritePost *.{hcl,nomad,terraform,tf} FormatWrite
  autocmd BufWritePost *.{yaml,yml} FormatWrite
augroup END
]],
	true
)

require("formatter").setup {
	logging = true,
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
