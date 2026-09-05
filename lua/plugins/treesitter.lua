return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			-- main branch: setup() only accepts install_dir; parsers via install()
			require("nvim-treesitter").install({
				"query",
				"c",
				"go",
				"rust",
				"php",
				"python",
				"lua",
				"json",
				"toml",
				"vue",
				"css",
				"html",
				"bash",
				"hcl",
			})

			vim.treesitter.language.register("hcl", "nomad")
			vim.treesitter.language.register("hcl", "tf")
			vim.treesitter.language.register("hcl", "terraform")

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
				callback = function(ev)
					if vim.bo[ev.buf].filetype == "markdown" then
						pcall(vim.treesitter.stop, ev.buf)
						return
					end
					local ok = pcall(vim.treesitter.start, ev.buf)
					if not ok then
						return
					end
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},

	-- Tree-sitter grammar for Justfiles
	"IndianBoy42/tree-sitter-just",
}
