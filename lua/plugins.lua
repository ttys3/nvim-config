-- This file can be loaded by calling `lua require('plugins')` from your init.vim

require "utils"

-- nnoremap { '<leader>hello', function() print("Hello world, from lua") end }

-- make the linter happy
local use = require("packer").use

return require("packer").startup {
	function()
		-- Packer can manage itself as an optional plugin
		use { "wbthomason/packer.nvim", opt = true }

		-- replacement
		-- add the following to init.lua to tell nvim not source the default filetype.vim
		-- vim.g.did_load_filetypes = 1
		-- following to core status: https://github.com/nathom/filetype.nvim/issues/36
		use {
			"nathom/filetype.nvim",
		}

		-- treesitter = AST (syntax/parsing)
		-- LSP = whole-project semantic analysis
		-- https://github.com/nvim-treesitter/nvim-treesitter
		use {
			"nvim-treesitter/nvim-treesitter",
			-- branch = "0.5-compat",
			run = ":TSUpdate",
			config = [[require('config.nvim-treesitter')]],
		}

		-- https://github.com/nvim-treesitter/playground
		-- use {
		-- 	"nvim-treesitter/playground",
		-- 	requires = { "nvim-treesitter/nvim-treesitter" },
		-- 	config = function()
		-- 		nnoremap {
		-- 			"<Leader>hl",
		-- 			[[:call luaeval("require'nvim-treesitter-playground.hl-info'.show_hl_captures()")<CR>]],
		-- 		}
		-- 	end,
		-- }

		use {
			"JoosepAlviste/nvim-ts-context-commentstring",
			requires = { "nvim-treesitter/nvim-treesitter" },
		}

		use {
			"kyazdani42/nvim-tree.lua",
			config = [[require('config.nvim-tree')]],
			requires = { "kyazdani42/nvim-web-devicons" },
		}

		-- use {
		-- 	"akinsho/bufferline.nvim",
		-- 	requires = "kyazdani42/nvim-web-devicons",
		-- 	config = function()
		-- 		require("bufferline").setup {}
		-- 	end,
		-- }

		-- support split window resizing and moving
		-- resize windows continuously by using typical keymaps of Vim. (h, j, k, l)
		-- use {
		-- 	"simeji/winresizer",
		-- 	config = function()
		-- 		Variable.g {
		-- 			winresizer_start_key = "<C-e>",
		-- 		}
		-- 		noremap { "<leader>nh", ":set nosplitright<CR>:vnew<CR>" }
		-- 		noremap { "<leader>nl", ":set splitright<CR>:vnew<CR>" }
		-- 		noremap { "<leader>nj", ":set splitbelow<CR>:new<CR>" }
		-- 		noremap { "<leader>nk", ":set nosplitbelow<CR>:new<CR>" }
		-- 	end,
		-- }
		--

		-- https://github.com/folke/todo-comments.nvim
		use {
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup {
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				}
			end,
		}

		-- use {
		-- 	"vim-test/vim-test",
		-- 	config = [[require('config.vim-test')]],
		-- }

		-- Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
		-- related works: godlygeek/tabular
		use {
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
		}

		-- https://github.com/karb94/neoscroll.nvim
		-- "psliwka/vim-smoothie",
		use {
			"karb94/neoscroll.nvim",
			config = function()
				require("neoscroll").setup()
			end,
		}

		-- https://github.com/simnalamburt/vim-mundo
		-- the diff https://github.com/simnalamburt/vim-mundo/issues/50
		-- https://simnalamburt.github.io/vim-mundo/#configuration
		use {
			"simnalamburt/vim-mundo",
			config = [[require('config.vim-mundo')]],
		}

		-- lsp
		use {
			"neovim/nvim-lspconfig",
			requires = "rcarriga/nvim-notify",
			config = [[require('config.nvim-lspconfig')]],
		}

		-- https://github.com/j-hui/fidget.nvim/blob/main/doc/fidget.md
		-- Standalone UI for nvim-lsp progress
		-- see https://github.com/j-hui/fidget.nvim/blob/main/lua/fidget/spinners.lua for predefined spinners
		-- use {
		-- 	"j-hui/fidget.nvim",
		-- 	config = function()
		-- 		require("fidget").setup {
		-- 			text = {
		-- 				spinner = "meter",
		-- 			},
		-- 		}
		-- 	end,
		-- }

		-- " illuminate.vim - Vim plugin for automatically highlighting other uses of the word under the cursor.
		-- " Integrates with Neovim's LSP client for intelligent highlighting.
		use {
			"rrethy/vim-illuminate",
			config = function()
				vim.g.Illuminate_ftblacklist = { "NvimTree" }
			end,
		}

		-- https://github.com/ray-x/lsp_signature.nvim
		use "ray-x/lsp_signature.nvim"

		-- vista.vim: A tagbar alternative that supports LSP symbols and async processing
		use {
			"liuchengxu/vista.vim",
			config = function()
				vim.g.vista_default_executive = "nvim_lsp"
				nnoremap { "<F3>", ":Vista!!<CR>" }
			end,
		}

		-- A pretty diagnostics list to help you solve all the trouble your code is causing.
		-- https://github.com/folke/lsp-trouble.nvim
		-- use {
		--     folke/lsp-trouble.nvim",
		--     config = [[require('config.lsp-trouble')]],
		-- }

		-- Lang extra

		-- RON: Rusty Object Notation
		use "ron-rs/ron.vim"

		-- vala
		-- https://github.com/arrufat/vala.vim
		-- Automatic detection of .vala, .vapi and .valadoc files
		-- https://wiki.gnome.org/action/show/Projects/Vala/Tools/Vim?action=show
		use {
			"arrufat/vala.vim",
			config = [[require('config.vala')]],
		}

		-- https://github.com/simrat39/rust-tools.nvim
		use {
			"simrat39/rust-tools.nvim",
			config = [[require('config.rust-tools')]],
		}

		-- edting

		-- Snippet support
		-- " https://github.com/SirVer/ultisnips/blob/master/doc/UltiSnips.txt
		-- " UltiSnips will search each 'runtimepath' directory for the subdirectory names
		-- " defined in g:UltiSnipsSnippetDirectories in the order they are defined.
		-- " Note that "snippets" is reserved for snipMate snippets and cannot be used in this list.
		-- " If the list has only one entry that is an absolute path, UltiSnips will not
		-- " iterate through &runtimepath but only look in this one directory for snippets.
		-- " This can lead to significant speedup. This means you will miss out on snippets
		-- " that are shipped with third party plugins. You'll need to copy them into this
		-- " directory manually.
		-- " mkdir -p $HOME/.config/nvim/UltiSnip
		-- use {
		-- 	"SirVer/ultisnips",
		-- 	requires = { "honza/vim-snippets" },
		-- 	config = [[require('config.ultisnips')]],
		-- }
		-- use "quangnguyen30192/cmp-nvim-ultisnips"

		-- For luasnip user.
		use {
			"L3MON4D3/LuaSnip",
			requires = { "rafamadriz/friendly-snippets" },
		}
		use "saadparwaiz1/cmp_luasnip"

		-- https://github.com/Saecki/crates.nvim
		-- also provide Completion source for nvim-cmp
		use {
			"Saecki/crates.nvim",
			-- lazy loading
			event = { "BufRead Cargo.toml" },
			requires = { { "nvim-lua/plenary.nvim" } },
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
		}

		-- complete plugin
		use "hrsh7th/cmp-nvim-lsp"
		use "hrsh7th/cmp-nvim-lua"
		-- use "hrsh7th/cmp-omni"
		use "hrsh7th/cmp-buffer"
		use "hrsh7th/cmp-path"
		use {
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			requires = "hrsh7th/nvim-cmp",
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
		}
		use {
			"hrsh7th/nvim-cmp",
			config = [[require('config.nvim-cmp')]],
		}

		-- https://github.com/windwp/nvim-autopairs
		-- https://github.com/steelsojka/pears.navim
		use {
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
		}

		-- " https://github.com/RishabhRD/nvim-cheat.sh
		-- " curl -sSf https://cht.sh/:cht.sh > ~/.local/bin/cht.sh && chmod +x ~/.local/bin/cht.sh
		-- usage: :Cheat cpp reverse number
		use { "RishabhRD/nvim-cheat.sh", requires = "RishabhRD/popfix" }

		-- debugger
		-- https://github.com/jodosha/vim-godebug
		-- https://github.com/puremourning/vimspector

		-- dap https://microsoft.github.io/debug-adapter-protocol/implementors/tools/
		-- https://github.com/mfussenegger/nvim-dap

		use {
			"mfussenegger/nvim-dap",
			requires = { "theHamsta/nvim-dap-virtual-text" },
			config = [[require('config.nvim-dap')]],
		}
		-- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

		-- use {
		-- 	"dstein64/nvim-scrollview",
		-- 	branch = "main",
		-- 	config = function()
		-- 		Variable.g {
		-- 			scrollview_on_startup = true,
		-- 			scrollview_excluded_filetypes = {
		-- 				"NvimTree",
		-- 				"packer",
		-- 				"startify",
		-- 				"fugitive",
		-- 				"fugitiveblame",
		-- 				"vista_kind",
		-- 				"qf",
		-- 				"help",
		-- 			},
		-- 		}
		-- 	end,
		-- }

		-- quickfix
		-- " https://github.com/romainl/vim-qf
		-- " Vim-qf and all quickfix-related plugins necessarily have overlapping features and thus undefined behaviors.
		-- " Therefore, I don't recommend vim-qf to Syntastic/Neomake/ALE users.
		-- " Plug 'romainl/vim-qf'
		-- " https://github.com/kevinhwang91/nvim-bqf
		use "kevinhwang91/nvim-bqf"

		use {
			"nvim-telescope/telescope.nvim",
			requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim" },
			config = [[require('config.telescope')]],
		}

		use {
			"numtostr/FTerm.nvim",
			config = [[require('config.fterm')]],
		}

		-- Automatic input method switching for vim
		-- https://github.com/rlue/vim-barbaric
		-- auto switch to en on normal
		-- 'kevinhwang91/vim-ibus-sw'
		use {
			"rlue/vim-barbaric",
			config = function()
				Variable.g {
					barbaric_ime = "fcitx",
					barbaric_default = 0,
					barbaric_scope = "buffer",
					barbaric_fcitx_cmd = "fcitx5-remote",
				}
			end,
		}

		-- use {
		-- 	"luochen1990/rainbow",
		-- 	config = function()
		-- 		Variable.g {
		-- 			rainbow_active = 1,
		-- 		}
		-- 	end,
		-- }

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
		use {
			"famiu/feline.nvim",
			config = [[require('config.feline')]],
		}

		use {
			"mhinz/vim-startify",
			config = [[require('config.vim-startify')]],
		}

		use {
			-- https://github.com/mhartington/formatter.nvim
			-- related work: https://github.com/lukas-reineke/format.nvim
			"mhartington/formatter.nvim",
			config = [[require('config.formatter')]],
		}

		-- https://github.com/glepnir/indent-guides.nvim
		use {
			"glepnir/indent-guides.nvim",
			config = [[require('config.indent-guides')]],
		}

		use "tpope/vim-surround"
		use "tpope/vim-repeat"
		-- " unimpaired has many useful maps, like
		-- " ]p pastes on the line below, [p pastes on the line above
		use "tpope/vim-unimpaired"

		-- https://github.com/b3nj5m1n/kommentary
		-- https://github.com/numToStr/Comment.nvim
		use {
			"numToStr/Comment.nvim",
			config = function()
				-- https://github.com/numToStr/Comment.nvim#configuration-optional
				require("Comment").setup()
			end,
		}

		-- Press + to expand the visual selection and _ to shrink it.
		use "terryma/vim-expand-region"

		-- " Plug 'easymotion/vim-easymotion'
		-- " like https://github.com/easymotion/vim-easymotion
		-- " https://github.com/goldfeld/vim-seek
		-- " emulate easymotion label and jump mode
		-- "justinmk/vim-sneak"
		use {
			"phaazon/hop.nvim",
			config = [[require('config.hop')]],
		}

		use {
			"mg979/vim-visual-multi",
			branch = "master",
		}

		use {
			"mfussenegger/nvim-lint",
			config = [[require('config.nvim-lint')]],
		}

		-- https://github.com/lewis6991/gitsigns.nvim
		use {
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = [[require('config.gitsigns')]],
		}

		-- " https://github.com/ttys3/vim-gomodifytags
		-- " Add or remove tags on struct fields with :GoAddTags and :GoRemoveTags
		use "ttys3/vim-gomodifytags"

		-- " generates method stubs for implementing an interface
		-- " :GoImpl {receiver} {interface}
		-- " :GoImpl f *File io.Reader
		-- " https://github.com/rhysd/vim-go-impl
		use "rhysd/vim-go-impl"

		-- https://github.com/norcalli/nvim-colorizer.lua
		use {
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		}

		--  https://github.com/iamcco/markdown-preview.nvim
		use {
			"iamcco/markdown-preview.nvim",
			run = function()
				vim.cmd "call mkdp#util#install()"
			end,
			config = [[require('config.markdown-preview')]],
		}

		-- https://github.com/plasticboy/vim-markdown#options
		use {
			"plasticboy/vim-markdown",
			config = [[require('config.vim-markdown')]],
		}

		use {
			"bfredl/nvim-miniyank",
			config = [[require('config.nvim-miniyank')]],
		}

		-- " NeoVim plugin to paste image from clipboard written in lua.
		-- " https://github.com/ekickx/clipboard-image.nvim
		use "ekickx/clipboard-image.nvim"

		-- https://jeffkreeftmeijer.com/vim-number/
		-- use "jeffkreeftmeijer/vim-numbertoggle"

		-- colorscheme

		-- https://github.com/EdenEast/nightfox.nvim
		use {
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
		}
		-- " one dark like colorscheme
		use "sainnhe/edge"

		-- " https://github.com/morhetz/gruvbox/wiki/Installation
		-- use "doums/darcula"
		-- use "ttys3/base16-vim"

		-- use {
		-- 	"arcticicestudio/nord-vim",
		-- 	config = function()
		-- 		vim.cmd [[ silent! colorscheme nord ]]
		-- 	end,
		-- }

		-- disabled due to bug https://github.com/shaunsingh/nord.nvim/issues/24
		-- use {
		-- 	"shaunsingh/nord.nvim",
		-- 	config = function()
		-- 		-- require("nord").set()
		-- 	end,
		-- }

		-- use "sainnhe/gruvbox-material"
		-- use "hzchirs/vim-material"

		-- use {
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
		-- use {
		-- 	"projekt0n/github-nvim-theme",

		-- 	config = function()
		-- 		require("github-theme").setup {
		-- 			-- set theme variant (options: dark/dark_default/dimmed/light/light_default)
		-- 			theme_style = "dark",
		-- 			-- theme_style = "dimmed",
		-- 		}
		-- 	end,
		-- }
	end,
	config = {
		log = { level = os.getenv "PACKER_LOG_LEVEL" or "warn" },
		display = {
			non_interactive = os.getenv "PACKER_NON_INTERACTIVE" or false,
			open_fn = function()
				return require("packer.util").float { border = "single" }
			end,
		},
	},
}
