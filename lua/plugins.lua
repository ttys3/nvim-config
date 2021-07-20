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
		use {
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = [[require('config.nvim-treesitter')]],
		}

		-- https://github.com/nvim-treesitter/playground
		use {
			"nvim-treesitter/playground",
			requires = { "nvim-treesitter/nvim-treesitter" },
			config = function()
				nnoremap {
					"<Leader>hl",
					[[:call luaeval("require'nvim-treesitter-playground.hl-info'.show_hl_captures()")<CR>]],
				}
			end,
		}

		use {
			"JoosepAlviste/nvim-ts-context-commentstring",
			requires = { "nvim-treesitter/nvim-treesitter" },
		}

		-- Lang extra

		-- https://github.com/chr4/sslsecure.vim
		-- Highlight insecure SSL configuration in Vim (works for all OpenSSL/ LibreSSL cipher strings, independent of the filetype)
		use "chr4/sslsecure.vim"

		-- Improved nginx vim plugin (incl. syntax highlighting)
		-- https://github.com/chr4/nginx.vim
		use "chr4/nginx.vim"

		-- Use specific branch, dependency and run lua file after load
		use {
			"kyazdani42/nvim-tree.lua",
			config = [[require('config.nvim-tree')]],
			requires = { "kyazdani42/nvim-web-devicons" },
		}

		-- vista.vim: A tagbar alternative that supports LSP symbols and async processing
		use {
			"liuchengxu/vista.vim",
			config = function()
				vim.g.vista_default_executive = "nvim_lsp"
				nnoremap { "<F3>", ":Vista!!<CR>" }
			end,
		}

		-- support split window resizing and moving
		-- resize windows continuously by using typical keymaps of Vim. (h, j, k, l)
		use {
			"simeji/winresizer",
			config = function()
				Variable.g {
					winresizer_start_key = "<C-e>",
				}
				noremap { "<leader>nh", ":set nosplitright<CR>:vnew<CR>" }
				noremap { "<leader>nl", ":set splitright<CR>:vnew<CR>" }
				noremap { "<leader>nj", ":set splitbelow<CR>:new<CR>" }
				noremap { "<leader>nk", ":set nosplitbelow<CR>:new<CR>" }
			end,
		}

		use "ttys3/vim-todo-highlight"

		-- "escaping insert mode without lagging
		-- "https://github.com/jdhao/better-escape.vim
		-- use "jdhao/better-escape.vim"

		use {
			"vim-test/vim-test",
			config = [[require('config.vim-test')]],
		}

		-- Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
		-- related works: godlygeek/tabular
		use {
			"junegunn/vim-easy-align",
			config = function() -- Start interactive EasyAlign in visual mode (e.g. vipga)        xmap{ "ga", "<Plug>(EasyAlign)" }
				-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
				nmap { "ga", "<Plug>(EasyAlign)" }
				-- Start interactive EasyAlign in visual mode (e.g. vipga)
				xmap { "ga", "<Plug>(EasyAlign)" }
			end,
		}
		-- https://github.com/psliwka/vim-smoothie
		-- default mapping: ^D ^U ^F ^B
		-- let g:smoothie_no_default_mappings = false
		-- experimental mappings (currently gg and G)

		use {
			"psliwka/vim-smoothie",
			config = function()
				vim.g.smoothie_experimental_mappings = true
			end,
		}

		use "jremmen/vim-ripgrep"

		-- https://github.com/simnalamburt/vim-mundo
		-- the diff https://github.com/simnalamburt/vim-mundo/issues/50
		-- https://simnalamburt.github.io/vim-mundo/#configuration
		use {
			"simnalamburt/vim-mundo",
			config = [[require('config.vim-mundo')]],
		}

		-- Lang extra

		use {
			"StanAngeloff/php.vim",
			config = function()
				Augroup {
					PhpSyntaxOverride = {
						{
							"FileType",
							"php",
							function()
								vim.api.nvim_command "hi! link phpDocTags phpDefine"
								vim.api.nvim_command "hi! link phpDocParam phpType"
							end,
						},
					},
				}
			end,
		}

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

		-- https://github.com/euclidianAce/BetterLua.vim
		use "euclidianAce/BetterLua.vim"

		use {
			-- "neovim/nvim-lspconfig",
			"ttys3/nvim-lspconfig",
			config = [[require('config.nvim-lspconfig')]],
		}

		-- https://github.com/simrat39/rust-tools.nvim
		use {
			"simrat39/rust-tools.nvim",
			config = [[require('config.rust-tools')]],
		}

		-- https://github.com/ray-x/lsp_signature.nvim
		use "ray-x/lsp_signature.nvim"

		-- https://github.com/glepnir/lspsaga.nvim
		use {
			"glepnir/lspsaga.nvim",
			config = [[require('config.lspsaga')]],
		}

		-- vscode-like completion icons
		-- similar: https://www.reddit.com/r/neovim/comments/lcqele/vscodelike_completion_icons/gm2e077/
		use {
			"onsails/lspkind-nvim",
			config = function()
				require("lspkind").init()
			end,
		}

		-- https://github.com/kosayoda/nvim-lightbulb
		-- shows a lightbulb in the sign column whenever a textDocument/codeAction is available at the current cursor position.
		use {
			"kosayoda/nvim-lightbulb",
			config = function()
				vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
			end,
		}

		-- A pretty diagnostics list to help you solve all the trouble your code is causing.
		-- https://github.com/folke/lsp-trouble.nvim
		-- use {
		--     folke/lsp-trouble.nvim",
		--     config = [[require('config.lsp-trouble')]],
		-- }

		-- """ edting
		-- " https://github.com/tpope/vim-endwise
		-- " need imap <cr>, not compatible with complete-nvim even with fallback <cr> mapping
		-- " since UltiSnips can do most of the work
		-- " this plugin can be disabled
		-- " see https://github.com/tpope/vim-endwise/issues/22
		-- " Plug 'tpope/vim-endwise'

		use "chrisbra/NrrwRgn"

		--     " https://github.com/jiangmiao/auto-pairs
		-- " AutoPairsReturn() also need imap <cr>
		-- " use fallback mode for completion-nvim, can make this work again
		-- " https://github.com/nvim-lua/completion-nvim#changing-completion-confirm-key
		use "jiangmiao/auto-pairs"

		--     " https://github.com/rstacruz/vim-closer
		-- " need imap <cr>, only auto close when you press <cr> (Enter)
		-- " see https://github.com/rstacruz/vim-closer/issues/30
		-- " Plug 'rstacruz/vim-closer'

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

		use {
			"SirVer/ultisnips",
			requires = { "honza/vim-snippets" },
			config = [[require('config.ultisnips')]],
		}

		-- complete plugin
		use {
			"hrsh7th/nvim-compe",
			config = [[require('config.nvim-compe')]],
		}

		use { "tzachar/compe-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-compe" }

		-- " https://github.com/samirettali/shebang.nvim
		-- " inserts a shebang line when editing a new file
		use "samirettali/shebang.nvim"

		-- " https://github.com/RishabhRD/nvim-cheat.sh
		-- " curl -sSf https://cht.sh/:cht.sh > ~/.local/bin/cht.sh && chmod +x ~/.local/bin/cht.sh
		use "RishabhRD/nvim-cheat.sh"

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

		-- Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
		-- minimap_auto_start = 0,
		-- minimap_width = 10,
		use {
			"dstein64/nvim-scrollview",
			branch = "main",
			config = function()
				Variable.g {
					scrollview_on_startup = true,
					scrollview_excluded_filetypes = {
						"NvimTree",
						"packer",
						"startify",
						"fugitive",
						"fugitiveblame",
						"vista_kind",
						"qf",
						"help",
					},
				}
			end,
		}

		-- quickfix
		-- " https://github.com/romainl/vim-qf
		-- " Vim-qf and all quickfix-related plugins necessarily have overlapping features and thus undefined behaviors.
		-- " Therefore, I don't recommend vim-qf to Syntastic/Neomake/ALE users.
		-- " Plug 'romainl/vim-qf'
		-- " https://github.com/kevinhwang91/nvim-bqf
		use "kevinhwang91/nvim-bqf"

		use "Rasukarusan/vim-block-paste"

		use {
			"nvim-telescope/telescope.nvim",
			requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzy-native.nvim" },
			config = [[require('config.telescope')]],
		}

		-- use {
		-- 	"liuchengxu/vim-clap",
		-- 	run = ":Clap install-binary!",
		-- 	config = [[require('config.vim-clap')]],
		-- }

		-- " https://github.com/voldikss/vim-floaterm
		-- " pip3 install --user neovim
		-- " pip3 install --user neovim-remote
		-- " if use git in floaterm, remember to set git default editor to nvim
		-- " otherwise will result in vim error: Unknown function: stdpath
		-- " export GIT_EDITOR=nvim
		-- " export EDITOR=nvim
		-- " export VISUAL=nvim
		-- use {
		-- 	"voldikss/vim-floaterm",
		-- 	config = [[require('config.vim-floaterm')]],
		-- }

		use {
			"numtostr/FTerm.nvim",
			config = [[require('config.fterm')]],
		}

		-- Toggle off the capslock when back to normal mode, ---that is what this plugin do
		-- use { "suxpert/vimcaps", run = "cd autoload && make" }

		-- " Keep and restore fcitx state for each buffer separately when leaving/re-entering insert mode.
		-- " Like always typing English in normal mode, but Chinese in insert mode.
		-- lilydjwg/fcitx.vim implemented with py3 + dbus, startuptime took 50ms, too slow
		-- use {
		-- 	"lilydjwg/fcitx.vim",
		-- 	branch = "fcitx5",
		-- }

		-- Automatic input method switching for vim
		-- https://github.com/rlue/vim-barbaric
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

		-- " auto switch to en on normal
		-- " Plug 'rlue/vim-barbaric'
		-- "Plug 'kevinhwang91/vim-ibus-sw'

		use {
			"luochen1990/rainbow",
			config = function()
				Variable.g {
					rainbow_active = 1,
					-- " oblitum mod version has bug, will mess up php syntax highlighting
					-- " Plug 'oblitum/rainbow'
					-- " Plug 'kien/rainbow_parentheses.vim'
					-- " https://github.com/p00f/nvim-ts-rainbow
					-- " Plug 'p00f/nvim-ts-rainbow'
				}
			end,
		}

		-- VCS
		-- https://github.com/lambdalisue/gina.vim
		use "lambdalisue/gina.vim"

		use {
			"ttys3/nvim-blamer.lua",
			config = [[require('config.nvim-blamer')]],
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
			"mhinz/vim-startify",
			config = [[require('config.vim-startify')]],
		}

		use {
			"nvim-lua/lsp-status.nvim",
			config = [[require('config.lsp-status')]],
		}

		use {
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

		-- " Use gcc to comment out a line (takes a count),
		-- " gc to comment out the target of a motion (for example, gcap to comment out a paragraph),
		-- " gc in visual mode to comment out the selection, and gc in operator pending mode to target a comment.
		-- " You can also use it as a command, either with a range like :7,17Commentary, or
		-- " as part of a :global invocation like with :g/TODO/Commentary. That's it.
		use "tpope/vim-commentary"

		use {
			"bfredl/nvim-miniyank",
			config = [[require('config.nvim-miniyank')]],
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

		--     " signify show git diff sigs
		-- " Plug 'mhinz/vim-signify'
		-- " https://github.com/lewis6991/gitsigns.nvim
		-- Plug 'nvim-lua/plenary.nvim'
		-- Use dependency and run lua function after load
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

		use {
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup()
			end,
		}

		-- " https://github.com/norcalli/nvim-colorizer.lua
		-- " Plug 'norcalli/nvim-colorizer.lua'

		-- " illuminate.vim - Vim plugin for automatically highlighting other uses of the word under the cursor.
		-- " Integrates with Neovim's LSP client for intelligent highlighting.
		use "rrethy/vim-illuminate"

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
			"dhruvasagar/vim-table-mode",
			-- For Markdown-compatible tables use
			config = function()
				vim.g.table_mode_corner = "|"
			end,
		}

		use {
			"voldikss/vim-translator",
			config = [[require('config.vim-translator')]],
		}

		-- https://github.com/pwntester/octo.nvim
		-- Edit and review GitHub issues and pull requests from the comfort of your favorite editor
		use {
			"pwntester/octo.nvim",
			requires = { "nvim-telescope/telescope.nvim", "kyazdani42/nvim-web-devicons" },
			config = function()
				vim.defer_fn(function()
					-- the setup is slow
					require("octo").setup()
				end, 6000)
			end,
		}

		-- " NeoVim plugin to paste image from clipboard written in lua.
		-- " https://github.com/ekickx/clipboard-image.nvim
		use "ekickx/clipboard-image.nvim"

		-- https://jeffkreeftmeijer.com/vim-number/
		-- use "jeffkreeftmeijer/vim-numbertoggle"

		-- " colorscheme
		-- " https://github.com/morhetz/gruvbox/wiki/Installation
		-- use 'joshdick/onedark.vim'
		use "doums/darcula"
		use "ttys3/base16-vim"
		use {
			"shaunsingh/nord.nvim",
			config = function()
				require("nord").set()
			end,
		}
		-- " one dark like colorscheme
		use "sainnhe/edge"
		use "sainnhe/gruvbox-material"
		use "hzchirs/vim-material"

		use {
			"npxbr/gruvbox.nvim",
			requires = { "rktjmp/lush.nvim" },
			config = function()
				Variable.g {
					gruvbox_bold = 0,
					gruvbox_italic = 1,
					-- " gruvbox_transparent_bg = 0
					-- " soft, medium and hard
					-- gruvbox_contrast_dark = "soft",
					gruvbox_contrast_dark = "medium",
				}
				vim.go.background = "dark"
				-- vim.cmd "colorscheme gruvbox"
				-- vim.cmd [[ silent! colorscheme gruvbox ]]
				-- print "colorscheme set to gruvbox"
			end,
		}
		-- use 'ttys3/gruvbox.nvim'
		-- " https://github.com/olimorris/onedark.nvim
		use "olimorris/onedark.nvim"

		-- You can alias plugin names
		use { "dracula/vim", as = "dracula" }
	end,
	config = {
		display = {
			non_interactive = os.getenv "PACKER_NON_INTERACTIVE" or false,
			open_fn = function()
				return require("packer.util").float { border = "single" }
			end,
		},
	},
}
