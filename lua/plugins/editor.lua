return {
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("spectre").setup({})
			vim.keymap.set("n", "<leader>S", function()
				require("spectre").open()
			end, { silent = true })
			vim.keymap.set("n", "<leader>sw", function()
				require("spectre").open_visual({ select_word = true })
			end, { silent = true })
			vim.keymap.set("v", "<leader>S", function()
				require("spectre").open_visual()
			end, { silent = true })
			vim.keymap.set("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<cr>", { silent = true })
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	},

	{
		"junegunn/vim-easy-align",
		config = function()
			vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { remap = true })
			vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { remap = true })
			vim.keymap.set("v", "<Leader>\\", ":EasyAlign*<Bar><Enter>")
		end,
	},

	{
		"windwp/nvim-autopairs",
		config = function()
			local npairs = require("nvim-autopairs")
			npairs.setup({
				check_ts = true,
				map_cr = true,
			})
			npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
		end,
	},

	"kevinhwang91/nvim-bqf",

	{
		"numtostr/FTerm.nvim",
		config = function()
			require("config.fterm")
		end,
	},

	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	"tpope/vim-repeat",

	-- phaazon/hop.nvim is archived. Community fork: smoka7/hop.nvim (not switching this pass).
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("config.hop")
		end,
	},

	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup({
				file_types = { "c", "rust", "go", "html", "javascript", "java", "swift", "lua", "python", "cpp" },
				hlgroup = "TSDefinitionUsage",
				animate = false,
			})
		end,
	},

	{
		"bfredl/nvim-miniyank",
		config = function()
			require("config.nvim-miniyank")
		end,
	},

	-- RON: Rusty Object Notation
	"ron-rs/ron.vim",

	{
		"arrufat/vala.vim",
		config = function()
			require("config.vala")
		end,
	},

	-- Linux/Fedora IME (fcitx5). Skipped on macOS when fcitx5-remote is absent.
	{
		"rlue/vim-barbaric",
		cond = function()
			return vim.fn.executable("fcitx5-remote") == 1
		end,
		config = function()
			vim.g.barbaric_ime = "fcitx"
			vim.g.barbaric_default = 0
			vim.g.barbaric_scope = "buffer"
			vim.g.barbaric_fcitx_cmd = "fcitx5-remote"
		end,
	},

	-- Dropped clipboard-image.nvim. Wait for Nvim 0.13 vim.ui.img;
	-- paste-to-markdown is not equivalent.
}
