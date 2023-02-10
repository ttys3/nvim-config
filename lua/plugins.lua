-- This file can be loaded by calling `lua require('plugins')` from your init.vim

require "utils"

-- nnoremap { '<leader>hello', function() print("Hello world, from lua") end }

-- make the linter happy
local use = require("packer").use

return require("packer").startup {
				function()
					-- Packer can manage itself as an optional plugin
					use { "wbthomason/packer.nvim", opt = true }

					-- treesitter = AST (syntax/parsing)
					-- LSP = whole-project semantic analysis
					-- https://github.com/nvim-treesitter/nvim-treesitter
					use {
							"nvim-treesitter/nvim-treesitter",
							-- branch = "0.5-compat",
							run = ":TSUpdate",
							config = [[require('config.nvim-treesitter')]],
					}

					use {
							"JoosepAlviste/nvim-ts-context-commentstring",
							requires = { "nvim-treesitter/nvim-treesitter" },
					}

					-- alternatives: https://github.com/nvim-neo-tree/neo-tree.nvim
					use {
							"kyazdani42/nvim-tree.lua",
							config = [[require('config.nvim-tree')]],
							requires = { "kyazdani42/nvim-web-devicons" },
					}

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

					use {
							"smjonas/inc-rename.nvim",
							config = function()
								require("inc_rename").setup()
								vim.keymap.set("n", "<leader>r", ":IncRename ")
							end,
					}

					-- local-highlight.nvim: blazing fast highlight of word under the cursor
					-- see https://www.reddit.com/r/neovim/comments/10xf7s0/comment/j7tjqgm/?utm_source=reddit&utm_medium=web2x&context=3
					use {
							'tzachar/local-highlight.nvim',
							config = function()
								require('local-highlight').setup({
										file_types = { 'c', 'rust', 'go', 'html', 'javascript', 'java', 'swift', 'lua', 'python', 'cpp' },
										hlgroup = 'TSDefinitionUsage',
								})
							end
					}


					-- https://github.com/ray-x/lsp_signature.nvim
					use "ray-x/lsp_signature.nvim"

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
					-- For luasnip user.
					use {
							"L3MON4D3/LuaSnip",
							requires = { "rafamadriz/friendly-snippets" },
							config = function()
								require("luasnip.loaders.from_vscode").lazy_load()
							end,
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
					use "hrsh7th/cmp-buffer"
					use "hrsh7th/cmp-path"

					-- use {
					-- 	"zbirenbaum/copilot.lua",
					-- 	event = { "VimEnter" },
					-- 	requires = "github/copilot.vim",
					-- 	config = function()
					-- 		vim.defer_fn(function()
					-- 			require("copilot").setup()
					-- 		end, 100)
					-- 	end,
					-- }

					-- use {
					-- 	"zbirenbaum/copilot-cmp",
					-- 	after = { "copilot.lua", "nvim-cmp" },
					-- }

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
							'goolord/alpha-nvim',
							requires = { 'nvim-tree/nvim-web-devicons' },
							config = function()
								require 'alpha'.setup(require 'alpha.themes.startify'.config)
								-- require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
							end
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

					use {
							"kylechui/nvim-surround",
							tag = "*", -- Use for stability; omit to use `main` branch for the latest features
							config = function()
								require("nvim-surround").setup({
										-- Configuration here, or leave empty to use defaults
								})
							end
					}

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

					-- https://github.com/ggandor/leap.nvim
					use {
							"phaazon/hop.nvim",
							branch = "v2",
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

					use {
							'ruifm/gitlinker.nvim',
							requires = 'nvim-lua/plenary.nvim',
							config = function()
								require "gitlinker".setup({
										opts = {
												-- callback for what to do with the url
												-- action_callback = require "gitlinker.actions".copy_to_clipboard,
												action_callback = require "gitlinker.actions".open_in_browser,
												-- print the url after performing the action
												print_url = true,
										},
										-- default mapping to call url generation with action_callback
										mappings = "<leader>gy"
								})
							end
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
