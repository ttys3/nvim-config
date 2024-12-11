-- This file can be loaded by calling `lua require('plugins')` from your init.vim

require "utils"

-- nnoremap { '<leader>hello', function() print("Hello world, from lua") end }

require("lazy").setup({
	-- treesitter = AST (syntax/parsing)
	-- LSP = whole-project semantic analysis
	-- https://github.com/nvim-treesitter/nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		-- branch = "0.5-compat",
		build = ":TSUpdate",
		config = function()
			require "config.nvim-treesitter"
		end,
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	-- https://github.com/IndianBoy42/tree-sitter-just
	-- Tree-sitter grammar for Justfiles (https://github.com/casey/just)
	"IndianBoy42/tree-sitter-just",

	-- alternatives: https://github.com/nvim-neo-tree/neo-tree.nvim
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require "config.neo-tree"
		end,
	},
	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	config = function()
	-- 		require "config.nvim-tree"
	-- 	end,
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- },
	--
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("spectre").setup {}
			-- open
			vim.api.nvim_set_keymap("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>", { silent = true })

			-- search current word
			vim.api.nvim_set_keymap("n", "<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { silent = true })
			vim.api.nvim_set_keymap("v", "<leader>S", "<esc>:lua require('spectre').open_visual()<CR> ", { silent = true })

			-- search in current file
			vim.api.nvim_set_keymap("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<cr>", { silent = true })
		end,
	},

	-- https://github.com/folke/todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
		end,
	},

	-- Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
	-- related works: godlygeek/tabular
	{
		"junegunn/vim-easy-align",
		config = function()
			-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
			nmap { "ga", "<Plug>(EasyAlign)" }
			-- Start interactive EasyAlign in visual mode (e.g. vipga)
			xmap { "ga", "<Plug>(EasyAlign)" }
			-- Align GitHub-flavored Markdown tables
			-- https://thoughtbot.com/blog/align-github-flavored-markdown-tables-in-vim
			vmap { "<Leader><Bslash>", ":EasyAlign*<Bar><Enter>" }
		end,
	},

	-- https://github.com/karb94/neoscroll.nvim
	-- "psliwka/vim-smoothie",
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		dependencies = { "rcarriga/nvim-notify" },
		config = function()
			require "config.nvim-lspconfig"
		end,
	},

	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
			vim.keymap.set("n", "<leader>r", ":IncRename ")
		end,
	},

	-- local-highlight.nvim: blazing fast highlight of word under the cursor
	-- see https://www.reddit.com/r/neovim/comments/10xf7s0/comment/j7tjqgm/?utm_source=reddit&utm_medium=web2x&context=3
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup {
				file_types = { "c", "rust", "go", "html", "javascript", "java", "swift", "lua", "python", "cpp" },
				hlgroup = "TSDefinitionUsage",
			}
		end,
	},

	-- https://github.com/ray-x/lsp_signature.nvim
	"ray-x/lsp_signature.nvim",

	-- Lang extra

	-- RON: Rusty Object Notation
	"ron-rs/ron.vim",

	-- vala
	-- https://github.com/arrufat/vala.vim
	-- Automatic detection of .vala, .vapi and .valadoc files
	-- https://wiki.gnome.org/action/show/Projects/Vala/Tools/Vim?action=show
	{
		"arrufat/vala.vim",
		config = function()
			require "config.vala"
		end,
	},

	-- edting

	-- Snippet support
	-- For luasnip user.
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = { "L3MON4D3/LuaSnip" },
	},

	-- https://github.com/Saecki/crates.nvim
	-- also provide Completion source for nvim-cmp
	{
		"Saecki/crates.nvim",
		-- lazy loading
		event = { "BufRead Cargo.toml" },
		dependencies = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("crates").setup()

			-- mappings https://github.com/Saecki/crates.nvim#key-mappings
			nnoremap { "<leader>vt", ":lua require('crates').toggle()<cr>" }
			nnoremap { "<leader>vr", ":lua require('crates').reload()<cr>" }
			nnoremap { "<leader>vu", ":lua require('crates').update_crate()<cr>" }
			vnoremap { "<leader>vu", ":lua require('crates').update_crates()<cr>" }
			nnoremap { "<leader>va", ":lua require('crates').update_all_crates()<cr>" }
			nnoremap { "<leader>vU", ":lua require('crates').upgrade_crate()<cr>" }
			vnoremap { "<leader>vU", ":lua require('crates').upgrade_crates()<cr>" }
			nnoremap { "<leader>vA", ":lua require('crates').upgrade_all_crates()<cr>" }
		end,
	},

	-- complete plugin
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			-- It is recommended to disable copilot.lua's suggestion and panel modules, 
			-- as they can interfere with completions properly appearing in copilot-cmp
			-- ref https://github.com/zbirenbaum/copilot-cmp
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},

	{
		-- Excessive rate limit violations issue, see https://github.com/zbirenbaum/copilot-cmp/issues/117
		-- "zbirenbaum/copilot-cmp",
		"tris203/copilot-cmp",
		branch = "getcompletions",
		after = { "copilot.lua", "nvim-cmp" },
		config = function ()
			require("copilot_cmp").setup()
		end
	},

	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = { "hrsh7th/nvim-cmp" },
		-- https://github.com/tzachar/cmp-tabnine#setup
		config = function()
			local tabnine = require "cmp_tabnine.config"
			tabnine:setup {
				max_lines = 1000,
				max_num_results = 20,
				sort = true,
				run_on_every_keystroke = true,
				snippet_placeholder = "..",
			}
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require "config.nvim-cmp"
		end,
	},

	-- https://github.com/windwp/nvim-autopairs
	-- https://github.com/steelsojka/pears.navim
	{
		"windwp/nvim-autopairs",
		config = function()
			-- https://github.com/windwp/nvim-autopairs/wiki/Endwise
			local npairs = require "nvim-autopairs"
			npairs.setup {
				check_ts = true,
			}
			npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")

			-- https://github.com/windwp/nvim-autopairs#mapping-cr
			-- [nvim-autopairs] function nvim-autopairs.completion.cmp setup is deprecated.
			-- [nvim-autopairs]you only need to add <cr> mapping on nvim-cmp.
		end,
	},

	-- quickfix
	-- " https://github.com/romainl/vim-qf
	-- " Vim-qf and all quickfix-related plugins necessarily have overlapping features and thus undefined behaviors.
	-- " Therefore, I don't recommend vim-qf to Syntastic/Neomake/ALE users.
	-- " Plug 'romainl/vim-qf'
	-- " https://github.com/kevinhwang91/nvim-bqf
	-- https://github.com/nvim-lua/wishlist/issues/21#issuecomment-1364100079
	-- https://github.com/debugloop/telescope-undo.nvim
	"kevinhwang91/nvim-bqf",

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			require "config.telescope"
		end,
	},

	{
		"numtostr/FTerm.nvim",
		config = function()
			require "config.fterm"
		end,
	},

	{
		"simrat39/rust-tools.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
		},
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	-- https://miguelcrespo.co/posts/how-to-debug-like-a-pro-using-neovim/
	-- https://www.reddit.com/r/neovim/comments/ot33sz/rusttoolsnvim_now_supports_debugging/
	-- https://alpha2phi.medium.com/neovim-for-beginners-debugging-using-dap-44626a767f57
	-- https://alpha2phi.medium.com/modern-neovim-debugging-and-testing-8deda1da1411
	-- https://github.com/alpha2phi/modern-neovim/blob/04-test/lua/plugins/dap/init.lua
	-- rust debug https://github.com/simrat39/rust-tools.nvim/wiki/Debugging
	-- https://github.com/mfussenegger/nvim-dap
	-- https://github.com/mfussenegger/nvim-dap/wiki/Extensions#language-specific-extensions
	-- go install github.com/go-delve/delve/cmd/dlv@latest
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			-- for lua
			"jbyuki/one-small-step-for-vimkind",
			-- for golang
			"leoluz/nvim-dap-go",
			-- for rust https://github.com/simrat39/rust-tools.nvim
			"neovim/nvim-lspconfig",
			"nvim-lua/plenary.nvim",
			"simrat39/rust-tools.nvim",
		},
		config = function()
			require("dap.ext.vscode").load_launchjs(nil, {})
			require("dap-go").setup()
			require "config.rust-tools"

			require("nvim-dap-virtual-text").setup {
				commented = true,
			}

			require("dap.lua").setup()
			-- lsp: RustDebugable
			-- require("dap.rust").setup()
			-- require("dap.golang").init()

			local dap, dapui = require "dap", require "dapui"

			-- enable this when you got trouble
			-- tail -f ~/.cache/nvim/dap.log
			--  Available log levels: TRACE DEBUG INFO WARN ERROR
			-- The log file is in the |stdpath| `cache` folder.
			-- To print the location:
			-- :lua print(vim.fn.stdpath('cache'))
			-- < The filename is `dap.log`
			dap.set_log_level "TRACE"

			dapui.setup {}

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

			-- toggle bp
			vim.keymap.set("n", "<leader>db", require("dap").toggle_breakpoint)

			-- run
			vim.keymap.set("n", "<F5>", require("dap").continue)
			-- step over
			vim.keymap.set("n", "<F9>", require("dap").step_over)
			-- step in
			vim.keymap.set("n", "<F10>", require("dap").step_into)
			-- step out
			vim.keymap.set("n", "<F12>", require("dap").step_out)

			-- run to cursor
			vim.keymap.set("n", "<F6>", require("dap").run_to_cursor)

			-- toggle dapui
			vim.keymap.set("n", "<leader>du", require("dapui").toggle)

			-- golang
			-- debug the closest method above the cursor
			vim.keymap.set("n", "<leader>dt", require("dap-go").debug_test)
			vim.keymap.set("n", "<leader>dl", require("dap-go").debug_last_test)
		end,
	},

	-- Automatic input method switching for vim
	-- https://github.com/rlue/vim-barbaric
	-- auto switch to en on normal
	-- 'kevinhwang91/vim-ibus-sw'
	{
		"rlue/vim-barbaric",
		config = function()
			Variable.g {
				barbaric_ime = "fcitx",
				barbaric_default = 0,
				barbaric_scope = "buffer",
				barbaric_fcitx_cmd = "fcitx5-remote",
			}
		end,
	},

	-- " if no color: export TERM=xterm-256color
	-- " show the final result: :echo &statusline
	-- " https://emojipedia.org/hourglass-done/
	-- " let g:lightline#ale#indicator_checking = "⌛ "
	-- " https://emojipedia.org/cross-mark/
	-- " let g:lightline#ale#indicator_errors = "❌ "
	-- " https://emojipedia.org/warning/
	-- " let g:lightline#ale#indicator_warnings = "⚠️  "
	-- " https://emojipedia.org/information/
	-- " let g:lightline#ale#indicator_infos = "ℹ️  "
	-- " https://emojipedia.org/check-mark-button/
	-- " let g:lightline#ale#indicator_ok = " ✅"

	{
		"windwp/windline.nvim",
		dependencies = { "linrongbin16/lsp-progress.nvim" },
		config = function()
			require "config.windline"
		end,
	},

	{
		"linrongbin16/lsp-progress.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lsp-progress").setup()
		end,
	},

	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
			-- require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
		end,
	},

	{
		-- https://github.com/mhartington/formatter.nvim
		-- related work: https://github.com/lukas-reineke/format.nvim
		"mhartington/formatter.nvim",
		config = function()
			require "config.formatter"
		end,
	},

	-- https://github.com/lukas-reineke/indent-blankline.nvim
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require "config.indent"
		end,
	},

	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup {
				-- Configuration here, or leave empty to use defaults
			}
		end,
	},

	"tpope/vim-repeat",
	-- " unimpaired has many useful maps, like
	-- " ]p pastes on the line below, [p pastes on the line above
	-- https://www.reddit.com/r/neovim/comments/118511i/minibracketed_go_forwardbackward_with_square/
	-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
	{ "echasnovski/mini.bracketed", version = false },

	-- https://github.com/b3nj5m1n/kommentary
	-- https://github.com/numToStr/Comment.nvim
	{
		"numToStr/Comment.nvim",
		config = function()
			-- https://github.com/numToStr/Comment.nvim#configuration-optional
			require("Comment").setup()
		end,
	},

	-- https://github.com/ggandor/leap.nvim
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require "config.hop"
		end,
	},
	{
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"smoka7/hydra.nvim",
		},
		opts = {},
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<Leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selected text or word under the cursor",
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			require "config.nvim-lint"
		end,
	},

	-- https://github.com/lewis6991/gitsigns.nvim
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require "config.gitsigns"
		end,
	},

	-- https://github.com/sindrets/diffview.nvim
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"ruifm/gitlinker.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitlinker").setup {
				callbacks = {
					["gitlab.gnome.org"] = require("gitlinker.hosts").get_gitlab_type_url,
					["code.pterclub.com"] = require("gitlinker.hosts").get_gitea_type_url,
				},
				opts = {
					-- callback for what to do with the url
					-- action_callback = require "gitlinker.actions".copy_to_clipboard,
					action_callback = require("gitlinker.actions").open_in_browser,
					-- print the url after performing the action
					print_url = true,
				},
				-- default mapping to call url generation with action_callback
				mappings = "<leader>gy",
			}
		end,
	},

	-- " https://github.com/ttys3/vim-gomodifytags
	-- " Add or remove tags on struct fields with :GoAddTags and :GoRemoveTags
	"ttys3/vim-gomodifytags",

	-- " generates method stubs for implementing an interface
	-- " :GoImpl {receiver} {interface}
	-- " :GoImpl f *File io.Reader
	-- " https://github.com/rhysd/vim-go-impl
	"rhysd/vim-go-impl",

	-- https://github.com/norcalli/nvim-colorizer.lua
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	--  https://github.com/iamcco/markdown-preview.nvim
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		config = function()
			require "config.markdown-preview"
		end,
	},

	-- https://github.com/plasticboy/vim-markdown#options
	{
		"plasticboy/vim-markdown",
		config = function()
			require "config.vim-markdown"
		end,
	},

	{
		"bfredl/nvim-miniyank",
		config = function()
			require "config.nvim-miniyank"
		end,
	},

	-- " NeoVim plugin to paste image from clipboard written in lua.
	-- " https://github.com/ekickx/clipboard-image.nvim
	"ekickx/clipboard-image.nvim",

	-- https://jeffkreeftmeijer.com/vim-number/
	-- use "jeffkreeftmeijer/vim-numbertoggle"

	-- colorscheme

	-- https://github.com/EdenEast/nightfox.nvim
	{
		"EdenEast/nightfox.nvim",
		config = function()
			local nightfox = require "nightfox"
			-- This function set the configuration of nightfox. If a value is not passed in the setup function
			-- it will be taken from the default configuration above
			-- https://github.com/EdenEast/nightfox.nvim
			nightfox.setup {
				options = {
					styles = {
						comments = "italic", -- change style of comments to be italic
						-- keywords = "bold", -- change style of keywords to be bold
						-- functions = "italic,bold", -- styles can be a comma separated list
					},
				},
			}

			vim.cmd [[ silent! colorscheme nordfox ]]
		end,
	},
	-- " one dark like colorscheme
	"sainnhe/edge",

	-- " https://github.com/morhetz/gruvbox/wiki/Installation
	-- use "doums/darcula"
	-- use "ttys3/base16-vim"

	-- {
	-- 	"arcticicestudio/nord-vim",
	-- 	config = function()
	-- 		vim.cmd [[ silent! colorscheme nord ]]
	-- 	end,
	-- }

	-- disabled due to bug https://github.com/shaunsingh/nord.nvim/issues/24
	-- {
	-- 	"shaunsingh/nord.nvim",
	-- 	config = function()
	-- 		-- require("nord").set()
	-- 	end,
	-- }

	-- use "sainnhe/gruvbox-material"
	-- use "hzchirs/vim-material"

	-- {
	-- 	"npxbr/gruvbox.nvim",
	-- 	requires = { "rktjmp/lush.nvim" },
	-- 	config = function()
	-- 		Variable.g {
	-- 			gruvbox_bold = 0,
	-- 			gruvbox_italic = 1,
	-- 			-- " gruvbox_transparent_bg = 0
	-- 			-- " soft, medium and hard
	-- 			-- gruvbox_contrast_dark = "soft",
	-- 			gruvbox_contrast_dark = "medium",
	-- 		}
	-- 		vim.go.background = "dark"
	-- 		-- vim.cmd "colorscheme gruvbox"
	-- 		-- vim.cmd [[ silent! colorscheme gruvbox ]]
	-- 		-- print "colorscheme set to gruvbox"
	-- 	end,
	-- }

	-- " https://github.com/olimorris/onedark.nvim
	-- use "olimorris/onedark.nvim"

	-- https://github.com/projekt0n/github-nvim-theme
	-- Github theme for Neovim
	-- {
	-- 	"projekt0n/github-nvim-theme",

	-- 	config = function()
	-- 		require("github-theme").setup {
	-- 			-- set theme variant (options: dark/dark_default/dimmed/light/light_default)
	-- 			theme_style = "dark",
	-- 			-- theme_style = "dimmed",
	-- 		}
	-- 	end,
	-- }
}, {
	log = { level = os.getenv "PACKER_LOG_LEVEL" or "warn" },
	display = {
		non_interactive = os.getenv "PACKER_NON_INTERACTIVE" or false,
		open_fn = function()
			return require("packer.util").float { border = "single" }
		end,
	},
})
