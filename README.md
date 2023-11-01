# My NeoVim Config

this repo: https://github.com/ttys3/nvim-config

* Following HEAD (nightly build), you should check https://github.com/neovim/neovim/issues/14090 daily
* nvim-treesitter Breaking Changes https://github.com/nvim-treesitter/nvim-treesitter/issues/2293
* Linux only


## Installation

```shell
# download the config
git clone https://github.com/ttys3/nvim-config.git $HOME/.config/nvim

cd $HOME/.config/nvim

# init plugin installation
nvim -i NONE -c "PackerInstall" -c "PackerCompile"

# init plugin installation (if you prefer non-interactive)
#env PACKER_NON_INTERACTIVE=1 nvim -i NONE -c "PackerInstall" -c "PackerCompile"

# stylua is used as lua formatter
# stylua installation
curl -LZ -o/tmp/stylua.zip "https://github.com/JohnnyMorganz/StyLua/releases/download/v0.18.2/stylua-linux-x86_64.zip"; \
cd /tmp; \
unzip stylua.zip; \
rm -f stylua.zip; \
sudo install -vDm 755 stylua /usr/local/bin; \
stylua --version
```

## Screenshot

![auto complete](https://user-images.githubusercontent.com/41882455/126368871-40bc204f-f804-47ba-811a-8200ff107fdf.png)

## Plugins Configuration

you can set `intelephense` license key in your `.zshrc` or `.bashrc`, if you have one.

> note: this is not necessary.

```shell
export INTELEPHENSE_LICENCE_KEY="xxxxxx"
```

## fonts

nerd font is required for Unicode emoji

please get a font at https://github.com/ryanoasis/nerd-fonts

## NeoVim installation under ArchLinux

```shell
sudo pacman -S neovim
sudo pacman -S llvm
```

## NeoVim installation under Fedora
```shell
sudo dnf install -y neovim python3-neovim
sudo dnf install -y clang llvm
```

## Build from source and install

```
make nvim
```

## Packer.nvim

https://github.com/wbthomason/packer.nvim#quickstart

https://github.com/wbthomason/packer.nvim#usage

https://github.com/wbthomason/packer.nvim#custom-initialization

## Language related tools

```shell
# rust
make lang/rust

# golang
make lang/go

# lua
make lang/lua

# php
make lang/php
```

## TODO

https://github.com/steelsojka/pears.nvim

https://github.com/windwp/nvim-autopairs

https://github.com/mhartington/formatter.nvim

## lua api

<https://neovim.io/doc/user/api.html>

<https://neovim.io/doc/user/lsp.html>

## NeoVim Related Document

> The following changes may require users to update configuration, plugins, or expectations. Only breaking changes are mentioned here

<https://github.com/neovim/neovim/wiki/Following-HEAD>

<https://github.com/neovim/neovim/wiki/FAQ>

<https://github.com/neovim/neovim/wiki/Building-Neovim#optimized-builds>

<https://github.com/neovim/neovim/wiki/Introduction>

https://github.com/rockerBOO/awesome-neovim

https://github.com/nvim-lua/wishlist

https://github.com/nanotee/nvim-lua-guide#vimapinvim_replace_termcodes

NeoVim 0.5 features and the switch to init.lua https://oroques.dev/notes/neovim-init/

https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/lua/plugins.lua

https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/tj/plugins.lua

https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#completion-kinds

https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#auto-import

https://github.com/neovim/nvim-lspconfig/wiki/Project-local-settings

https://github.com/neovim/nvim-lspconfig/wiki/Snippets

https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips

## NeoVim lua func

vim.fn.xxx https://neovim.io/doc/user/eval.html#vim-function


## Plugin Description

why do you installed all of these plugins?

here is the simple reason.

- wbthomason/packer.nvim the package manager, essential
- nvim-treesitter/nvim-treesitter for better synatx highlighting, essential
- JoosepAlviste/nvim-ts-context-commentstring for context comment, essential
- kyazdani42/nvim-tree.lua the lua version nerd-tree, I use it every day
- kyazdani42/nvim-web-devicons Unicode emoji support, essential
- junegunn/vim-easy-align the must have align plugin, essential
- karb94/neoscroll.nvim for smooth scroll
- simnalamburt/vim-mundo best undo history plugin I've found, did not found a lua replacement
- ron-rs/ron.vim RON: Rusty Object Notation, yes, I also like Rust
- arrufat/vala.vim Automatic detection of .vala, .vapi and .valadoc files, as a GNOME user, sometimes I need work on a vala project
- neovim/nvim-lspconfig no need to say what is this, I use lsp everyday, essential
- simrat39/rust-tools.nvim for Rust lsp inlay hints support, works like a charm
- ray-x/lsp_signature.nvim Show function signature when you type, use it everyday
- L3MON4D3/LuaSnip + rafamadriz/friendly-snippets the snippet plugin and the snippets
- hrsh7th/nvim-cmp Auto completion Lua plugin for nvim, use it everyday
- tzachar/cmp-tabnine tabnine nvim-compe source, use it everyday
- kevinhwang91/nvim-bqf this plugin just works like a charm, a better quickfix
- nvim-telescope/telescope.nvim you know what this is
- numtostr/FTerm.nvim float term plugin, essential
- rlue/vim-barbaric switch input method, as a CJK lang user, this is essential
- windwp/windline.nvim the status line plugin, essential
- goolord/alpha-nvim MRU dashbaord plugin
- mhartington/formatter.nvim this plugin can do all kinds of auto formater for you, essential
- glepnir/indent-guides.nvim use it everyday, essential
- kylechui/nvim-surround Add/change/delete surrounding delimiter pairs with ease. Written with heart in Lua
- tpope/vim-repeat use it everyday, did not found a replacement
- echasnovski/mini.bracketed Go forward/backward with square brackets
- numToStr/Comment.nvim use it everyday, essential, maybe I will replace it with a lua one later
- folke/todo-comments.nvim TODO comments highlighting
- phaazon/hop.nvim the lua version vim-easymotion or vim-sneak, but better
- mg979/vim-visual-multi multi cursor plugin, essential
- mfussenegger/nvim-lint async lint plugin, essential
- lewis6991/gitsigns.nvim git sign plugin, essential
- ttys3/vim-gomodifytags as a golang user, essential
- rhysd/vim-go-impl as a golang user, essential
- norcalli/nvim-colorizer.lua when I edit CSS or HTML files, essential
- local-highlight.nvim: blazing fast highlight of word under the cursor
- iamcco/markdown-preview.nvim the must have plugin for me
- plasticboy/vim-markdown better markdown support
- ekickx/clipboard-image.nvim NeoVim plugin to paste image from clipboard written in lua.
- and last, Some of my favorite colorschemes: sainnhe/edge, EdenEast/nightfox.nvim (I use nordfox)

## other neovim config

A modern plugin manager for Neovim https://github.com/LazyVim/LazyVim
