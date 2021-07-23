OS := $(shell hostnamectl status | grep -i 'Operating System' | cut -d: -f2 | tr -d '[0-9. ]' | tr '[:upper:]' '[:lower:]')

.PHONY: all tools check nvim linter lang/go lang/php lang/lua lang/rust
# https://github.com/neovim/nvim-lspconfig

all:
	tools
	tools/zsh
	linter
	lang/go
	lang/rust
	lang/php
	lang/lua
	tools/cloud
	-@make $(OS)

archlinux: prepare/$(OS)

ubuntu: prepare/$(OS) tools/$(OS) tools/rust tools/go lua/$(OS) yarn/$(OS) vala/$(OS) luarocks symlink/ubuntu

prepare/archlinux:
	sudo pacman -S npm python-pip tree-sitter clang
	sudo pacman -S lua51 lua51-lpeg-patterns luajit
	sudo ln -sf /usr/bin/lua5.1 /usr/local/bin/lua
	export LUAROCKS_CONFIG=~/.luarocks/config-5.1.lua

prepare/ubuntu: ts-cli
	command -v ninja || sudo apt-get install -y ninja-build

tools:
	npm config set prefix ~/.local && npm config set registry=http://registry.npm.taobao.org
	npm i -g npm
	npm install -g fixjson
	npm install -g jsonlint
	npm i -g bash-language-server
	# General purpose Language Server that integrate with linter to support diagnostic features
	# https://github.com/iamcco/diagnostic-languageserver
	npm i -g diagnostic-languageserver
	npm install -g dockerfile-language-server-nodejs
	# get vscode-html-language-server, vscode-css-language-server and vscode-json-language-server
	# https://github.com/hrsh7th/vscode-langservers-extracted
	npm i -g vscode-langservers-extracted
	# python https://github.com/microsoft/pyright
	npm install -g pyright
	npm install -g typescript-language-server
	npm install -g vim-language-server
	# markdown linter https://github.com/igorshubovych/markdownlint-cli
	# npm install -g markdownlint-cli
	# https://docs.errata.ai/vale/cli
	curl -sfL https://install.goreleaser.com/github.com/ValeLint/vale.sh | sh -s - -b ~/.local/bin v2.10.2
	# vue
	npm install -g vls
	npm install -g yaml-language-server
	pip3 install --user --upgrade pynvim
	# https://github.com/mhinz/neovim-remote
	pip3 install --user --upgrade neovim-remote

tools/archlinux:
	sudo pacman -Syu mkcert
	sudo pacman -S copyq

lang/go:
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(shell go env GOPATH)/bin
	golangci-lint --version
	go get golang.org/x/tools/gopls@latest
	go get github.com/go-delve/delve/cmd/dlv@latest
	go get github.com/mgechev/revive
	go get golang.org/x/tools/cmd/goimports
	go get mvdan.cc/gofumpt/gofumports
	go get github.com/fatih/gomodifytags
	go get github.com/josharian/impl
	# binary optimze
	go get github.com/jondot/goweight
	go get github.com/bradfitz/shotizam
	# go test with colors
	go get github.com/rakyll/gotest
	go get github.com/kyoh86/richgo

# 🦀 https://www.rust-lang.org/tools/install
lang/rust:
	curl -LZ https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer && chmod +x ~/.local/bin/rust-analyzer
	# cargo add / rm / upgrade https://github.com/killercup/cargo-edit
	cargo install cargo-edit
	# https://github.com/kbknapp/cargo-outdated
	cargo install --locked cargo-outdated
	# https://github.com/RazrFalcon/cargo-bloat
	cargo install cargo-bloat --features regex-filter
	# https://doc.rust-lang.org/book/appendix-07-nightly-rust.html#rustup-and-the-role-of-rust-nightly
	rustup toolchain install nightly
	rustup toolchain list
	#  cd ~/projects/needs-nightly
	#  rustup override set nightly

lang/php:
	# php intelephense 1.7.1 https://www.npmjs.com/package/intelephense
	npm install -g intelephense

lang/lua:
	# https://github.com/lunarmodules/LDoc
	luarocks install penlight && luarocks install ldoc
	# https://github.com/jhawthorn/fzy
	# apt-get install fzy
	# https://github.com/swarn/fzy-lua
	luarocks install --local fzy
	# related works: https://github.com/romgrk/fzy-lua-native
	# https://github.com/mpeterv/luacheck
	luarocks install --local luacheck
	# lang server https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
	git clone https://github.com/sumneko/lua-language-server ~/.local/share/lua-language-server; \
	cd ~/.local/share/lua-language-server; \
	git submodule update --init --recursive; \
	cd ~/.local/share/lua-language-server/3rd/luamake; \
	ninja -f ninja/linux.ninja; \
	cd ~/.local/share/lua-language-server; \
	./3rd/luamake/luamake rebuild

linter:
	# https://yamllint.readthedocs.io/en/stable/quickstart.html#installing-yamllint
	pip3 install --user --upgrade yamllint
	# https://github.com/Vimjas/vint
	pip3 install --user --upgrade vim-vint
	# toml lint
	go get -u github.com/pelletier/go-toml/cmd/tomll
	# https://github.com/vmchale/tomlcheck
	# curl -o~/.local/bin/tomlcheck -LZ \
		# https://github.com/vmchale/tomlcheck/releases/download/0.1.0.38/tomlcheck-x86_64-unkown-linux-gnu


check:
	nvim -i NONE -c "checkhealth"

ts:
	nvim -i NONE -c "TSUninstall all" -c "qa"
	nvim -i NONE -c "TSInstallFromGrammar query c go rust php python lua json toml vue css html bash"

ts-cli:
	git clone https://github.com/tree-sitter/tree-sitter.git
	cd tree-sitter && cargo install .

pack/p:
	nvim -i NONE -c "PackerCompile profile=true" -c "PackerProfile"

pack/s:
	nvim -i NONE -c "PackerSync" -c "PackerCompile"

pack/i:
	nvim -i NONE -c "PackerInstall" -c "PackerCompile" 

pack/c:
	nvim -i NONE -c "PackerCompile" -c "qa"

pack/u:
	nvim -i NONE -c "PackerUpdate"

pack/q:
	nvim -i NONE -c "PackerUpdate" -c "qa"

lua/ubuntu:
	sudo apt-get install -y libluajit-5.1-dev liblua5.1-0-dev

yarn/ubuntu:
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt update && sudo apt install yarn
	#export PATH="$PATH:`yarn global bin`"

vala/ubuntu:
	# https://github.com/benwaffle/vala-language-server
	sudo apt-add-repository ppa:vala-team/next
	sudo apt-get install valac valac-bin libvala-0.52-dev
	# ls
	sudo add-apt-repository ppa:prince781/vala-language-server
	sudo apt-get update
	sudo apt-get install vala-language-server
	sudo apt install -y meson
	# for vala ls
	sudo apt install -y libgee-0.8-dev libjsonrpc-glib-1.0-dev scdoc
	# for peek
	sudo apt install -y libkeybinder-3.0-dev appstream-util txt2man

tools/ubuntu:
	# https://clangd.llvm.org/installation.html
	# clangd for c lang server, clang for build sumneko/lua-language-server
	sudo apt install -y clangd clang
	# Ubuntu 20.10 and newer
	sudo apt-get -y update
	sudo apt-get -y install podman
	sudo apt install -y universal-ctags
	# https://github.com/hluk/CopyQ
	sudo add-apt-repository ppa:hluk/copyq
	sudo apt update
	sudo apt install copyq
	# https://github.com/FiloSottile/mkcert
	go get filippo.io/mkcert

tools/fedora:
	sudo install -y copyq

devel/fedora:
	# x11 lib for suxpert/vimcaps
	sudo dnf install -y libX11-devel
	# compat-lua is lua5.1
	sudo dnf install compat-lua compat-lua-libs compat-lua-devel lua-filesystem-compat lua-socket-compat lua5.1-compat53 \
	lua5.1-luv-devel lua5.1-http lua5.1-lpeg lua5.1-luaossl \
	lua5.1-mmdb lua5.1-mpack lua5.1-psl lua5.1-sec lua5.1-basexx lua5.1-binaryheap lua5.1-bitop \
	luajit

luarocks:
	# append this to .zshrc to setup correct lua env vars: eval "$(luarocks path --bin)"
	curl -LZO https://luarocks.org/releases/luarocks-3.3.1.tar.gz
	tar xvzpf luarocks-3.3.1.tar.gz && \
		cd luarocks-3.3.1 && \
		./configure --with-lua-include=/usr/include/lua-5.1/ && \
		sudo make bootstrap

tools/zsh:
	# rg zsh auto complete
	# remember to append `fpath+=${ZDOTDIR:-~}/.zsh_functions` to ~/.zshrc
	curl -fLo $${ZDOTDIR:-~}/.zsh_functions/_rg --create-dirs https://github.com/BurntSushi/ripgrep/raw/master/complete/_rg
	curl -fLo $${ZDOTDIR:-~}/.zsh_functions/_fd --create-dirs https://github.com/sharkdp/fd/blob/master/contrib/completion/_fd
	# bat completion is disabled due to https://github.com/sharkdp/bat/pull/482/files

tools/rust:
	# https://github.com/chmln/sd
	command -v sd || cargo install sd
	# https://github.com/BurntSushi/ripgrep
	command -v rg || cargo install ripgrep
	# https://github.com/sharkdp/fd
	command -v fd || cargo install fd-find
	# https://github.com/sharkdp/bat
	command -v bat || cargo install bat
	# https://github.com/svenstaro/miniserve
	command -v miniserve || cargo install miniserve
	# sk fuzzy finder https://github.com/lotabout/skim
	command -v sk || cargo install skim
	# https://github.com/Peltoche/lsd
	command -v lsd || cargo install lsd
	# https://github.com/ajeetdsouza/zoxide  eval "$(zoxide init zsh)"
	command -v zoxide|| cargo install zoxide
	# https://github.com/yaa110/nomino
	cargo install nomino
	# https://github.com/kl/sub-batch
	cargo install sub-batch
	# Yet another HTTPie clone in Rust https://github.com/ducaale/xh
	cargo install xh
	# source code line count https://github.com/XAMPPRocky/tokei#installation
	cargo install tokei --features all
	# git commit --fixup, but automatic
	cargo install git-absorb

tools/go:
	# https://github.com/gsamokovarov/jump
	# ~/.zshrc put: eval "$(jump shell --bind=z)"
	go get github.com/gsamokovarov/jump
	# https://github.com/ayoisaiah/f2#installation
	go get -u github.com/ayoisaiah/f2/cmd/...
	# The power of curl, the ease of use of httpie. https://github.com/rs/curlie
	go get -u github.com/rs/curlie
	# It's like curl -v, with colours. https://github.com/davecheney/httpstat
	go get github.com/davecheney/httpstat
	# convert csv/tsv to markdown table https://github.com/monochromegane/mdt
	go get github.com/monochromegane/mdt/...

tools/cloud:
	go get github.com/juliosueiras/nomad-lsp
	go github.com/juliosueiras/terraform-lsp
	go install github.com/hashicorp/hcl/v2/cmd/hclfmt

push:
	git push origin main --tags

pull:
	git pull origin main --ff-only --tags

image:
	export REGISTRY_AUTH_FILE=/etc/containers/auth.json
	sudo touch /etc/containers/auth.json && \
		test -s /etc/containers/auth.json || echo '{}' | sudo tee /etc/containers/auth.json && \
		sudo chmod 600 /etc/containers/auth.json
	sudo BUILDAH_FORMAT=docker BUILDAH_LAYERS=true podman build -t neovim .

packer:
	git clone https://github.com/wbthomason/packer.nvim \
	~/.local/share/nvim/site/pack/packer/opt/packer.nvim

install:
	ansible-playbook -K ./nvim-fedora.yaml

nvim:
	# for ArchLinux you need: sudo pacman -R lua-lpeg 
	# because it belongs to lua 5.4 which will mess the build (make neovim link to the wrong lpeg.so)
	test -d neovim || git clone https://github.com/neovim/neovim.git
	# https://github.com/ninja-build/ninja/issues/1302
	sudo chown -R $$USER:$$GROUP ./neovim
	test -d neovim && cd neovim && git pull origin master --tags --force && make CMAKE_BUILD_TYPE=RelWithDebInfo -j$(($(nproc)+4)) && sudo make install && cd ../ && nvim --version


symlink/ubuntu:
	# show current alternatives
	update-alternatives --list editor
	update-alternatives --list vi
	update-alternatives --list vim
	# register nvim to alternatives
	sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/nvim 60
	sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/nvim 60
	sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/nvim 60
	# display
	update-alternatives --display vi
	update-alternatives --display vim
	update-alternatives --display editor
	# config nvim as default
	sudo update-alternatives --set vi /usr/local/bin/nvim
	sudo update-alternatives --set vim /usr/local/bin/nvim
	sudo update-alternatives --set editor /usr/local/bin/nvim
	# interactive config
	# sudo update-alternatives --config editor
	# sudo update-alternatives --config vi
	
	# pure all before debug problems
purge:
	rm -rf ~/.local/share/nvim && mkdir ~/.local/share/nvim && rm -rf ~/.cache/nvim && mkdir ~/.cache/nvim && rm -rf rm -rf /tmp/site
	# curl -fLo $$HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	# https://github.com/wbthomason/packer.nvim
	# git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# take screenshot of statusline
bar:
	# xrandr
	# xwininfo
	# xwininfo -id $(xdotool getactivewindow)
	rm -f {n,i,v,r,statusline}.png
	scrot -o -c -d8 -a0,1938,1910,34 n.png
	scrot -o -c -d8 -a0,1938,1910,34 i.png
	scrot -o -c -d8 -a0,1938,1910,34 v.png
	scrot -o -c -d8 -a0,1938,1910,34 r.png
	ffmpeg -y -i n.png -i i.png -i v.png -i r.png -filter_complex "[0][1][2][3]vstack=inputs=4" statusline.png
	xdg-open statusline.png

startuptime:
	nvim --startuptime startup.log -c ":q" && cat startup.log | sort -k2 && rm -f startup.log
