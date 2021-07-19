# My NeoVim Config

## Installation

```shell
# download the config
git clone https://github.com/ttys3/nvim-config.git $HOME/.config/nvim

# init plugin installation
env PACKER_NON_INTERACTIVE=1 nvim -i NONE -c "lua _G.packer_non_interactive=true;require('packer').install()" -c "PackerCompile"

# stylua is used as lua formatter
# stylua installation
curl -LZ -o/tmp/stylua.zip "https://github.com/JohnnyMorganz/StyLua/releases/download/v0.10.0/stylua-0.10.0-linux.zip"; \
cd /tmp; \
unzip stylua.zip; \
rm -f stylua.zip; \
sudo install -vDm 755 stylua /usr/bin; \
stylua --version
```

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

