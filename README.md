# My NeoVim Config

## Installation

```shell
# download the config
git clone https://github.com/ttys3/nvim-config.git $HOME/.config/nvim

# init plugin installation
nvim -i NONE -c "PackerInstall" -c "PackerCompile"

# init plugin installation (if you prefer non-interactive)
#env PACKER_NON_INTERACTIVE=1 nvim -i NONE -c "PackerInstall" -c "PackerCompile"

# stylua is used as lua formatter
# stylua installation
curl -LZ -o/tmp/stylua.zip "https://github.com/JohnnyMorganz/StyLua/releases/download/v0.10.0/stylua-0.10.0-linux.zip"; \
cd /tmp; \
unzip stylua.zip; \
rm -f stylua.zip; \
sudo install -vDm 755 stylua /usr/bin; \
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
- nvim-treesitter/nvim-treesitter for better synatx highlighting,  essential 
- nvim-treesitter/playground for debug treesitter highlighting issue, dev & debug
- JoosepAlviste/nvim-ts-context-commentstring for context comment, essential
- chr4/sslsecure.vim Highlight insecure SSL configuration, devops 
- chr4/nginx.vim  Improved nginx vim plugin (incl. syntax highlighting), devops 
- kyazdani42/nvim-tree.lua the lua version nerd-tree, I use it every day
- kyazdani42/nvim-web-devicons Unicode emoji support, essential
- liuchengxu/vista.vim A tagbar alternative that supports LSP symbols and async processing
- simeji/winresizer resize windows continuously by using typical keymaps of Vim. (h, j, k, l)
- sakshamgupta05/vim-todo-highlight highligh improve, essential
- vim-test/vim-test I use it run golang test quickly, did not find a lua replacement.
- junegunn/vim-easy-align the must have align plugin, essential
- psliwka/vim-smoothie scroll improve
- simnalamburt/vim-mundo best undo history plugin I've found, did not found a lua replacement
- ron-rs/ron.vim RON: Rusty Object Notation, yes, I also like Rust
- arrufat/vala.vim Automatic detection of .vala, .vapi and .valadoc files, as a GNOME user, sometimes I need work on a vala project
- neovim/nvim-lspconfig no need to say what is this, I use lsp everyday, essential 
- simrat39/rust-tools.nvim for Rust lsp inlay hints support, works like a charm
- ray-x/lsp_signature.nvim Show function signature when you type, use it everyday
- chrisbra/NrrwRgn A Narrow Region Plugin for vim (like Emacs Narrow Region)
- SirVer/ultisnips + honza/vim-snippets the snippet plugin with lots of snippets, if you find another one better than this, please tell me, I do not mean the implementation, I mean, just install it, most of you fav language snippets just there and you can just use it.
- hrsh7th/nvim-compe Auto completion Lua plugin for nvim, use it everyday
- tzachar/compe-tabnine tabnine nvim-compe source, use it everyday
- RishabhRD/nvim-cheat.sh this plugin can make you copy and paste more effectively
- mfussenegger/nvim-dap the dap plugin, for interactive debug
- dstein64/nvim-scrollview  A Neovim plugin that displays interactive scrollbars.
- kevinhwang91/nvim-bqf this plugin just works like a charm, a better quickfix 
- nvim-telescope/telescope.nvim you know what this is
- numtostr/FTerm.nvim float term plugin, essential
- rlue/vim-barbaric switch input method, as a CJK lang user, this is essential
- luochen1990/rainbow better for nested quotes, this is essential to me, maybe I will replace it with a lua one
- lambdalisue/gina.vim the git plugin
- famiu/feline.nvim the status line plugin, essential
- mhinz/vim-startify best dashbaord plugin, even today I did not found a lua version replacement
- nvim-lua/lsp-status.nvim this is essential for me, if you are a Rust programmer, rust-analyzer lsp loading time is a bit more slow, without this plugin, you did not know what happend.
- mhartington/formatter.nvim this plugin can do all kinds of auto formater for you, essential
- glepnir/indent-guides.nvim use it everyday, essential
- tpope/vim-surround he most famous surround plugin, did not found a replacement
- tpope/vim-repeat use it everyday, did not found a replacement
- tpope/vim-unimpaired maybe I will remove this
- tpope/vim-commentary use it everyday, essential, maybe I will replace it with a lua one later
- terryma/vim-expand-region Press + to expand the visual selection and _ to shrink it.
- phaazon/hop.nvim the lua version vim-easymotion or vim-sneak, but better
- mg979/vim-visual-multi multi cursor plugin, essential
- mfussenegger/nvim-lint async lint plugin, essential
- lewis6991/gitsigns.nvim git sign plugin, essential
- ttys3/vim-gomodifytags as a golang user, essential
- rhysd/vim-go-impl as a golang user, essential
- norcalli/nvim-colorizer.lua when I edit CSS or HTML files, essential
- rrethy/vim-illuminate automatically highlighting other uses of the word under the cursor
- iamcco/markdown-preview.nvim the must have plugin for me
- plasticboy/vim-markdown better markdown support
- ekickx/clipboard-image.nvim NeoVim plugin to paste image from clipboard written in lua.
- and last, Some of my favorite colorschemes: doums/darcula  shaunsingh/nord.nvim sainnhe/edge sainnhe/gruvbox-material hzchirs/vim-material npxbr/gruvbox.nvim olimorris/onedark.nvim dracula/vim

