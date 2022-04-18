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
	npm i -g @tailwindcss/language-server
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
	# does not install via npm https://github.com/redhat-developer/yaml-language-server
	yarn global add yaml-language-server
	go install github.com/UltiRequiem/yamlfmt@latest
	pip3 install --user --upgrade pynvim
	# https://github.com/mhinz/neovim-remote
	pip3 install --user --upgrade neovim-remote

tools/archlinux:
	sudo pacman -S --needed mkcert
	# sudo pacman -S copyq
	# https://github.com/koalaman/shellcheck#installing
	paru -S --needed shellcheck-static
	# markdown linter https://github.com/errata-ai/vale
	#paru -S --needed vale-bin
	curl -SsfL https://github.com/errata-ai/vale/releases/download/v2.10.5/vale_2.10.5_Linux_64-bit.tar.gz | bsdtar -xzf - -C$$HOME/.local/bin/
	# https://github.com/hadolint/hadolint
	paru -S --needed hadolint-bin

lang/go:
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(shell go env GOPATH)/bin
	golangci-lint --version
	go install golang.org/x/tools/gopls@latest
	go install github.com/go-delve/delve/cmd/dlv@latest
	go install github.com/mgechev/revive
	go install golang.org/x/tools/cmd/goimports
	go install mvdan.cc/gofumpt/gofumports
	go install github.com/fatih/gomodifytags
	go install github.com/josharian/impl
	# binary optimze
	go install github.com/jondot/goweight
	go install github.com/bradfitz/shotizam
	# go test with colors
	go install github.com/rakyll/gotest
	go install github.com/kyoh86/richgo

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
	./compile/install.sh;\
	cd ~/.local/share/lua-language-server; \
	./3rd/luamake/luamake rebuild

linter:
	# https://yamllint.readthedocs.io/en/stable/quickstart.html#installing-yamllint
	pip3 install --user --upgrade yamllint
	# https://github.com/Vimjas/vint
	pip3 install --user --upgrade vim-vint
	# toml lint
	go install -u github.com/pelletier/go-toml/cmd/tomll
	# https://github.com/vmchale/tomlcheck
	# curl -o~/.local/bin/tomlcheck -LZ \
		# https://github.com/vmchale/tomlcheck/releases/download/0.1.0.38/tomlcheck-x86_64-unkown-linux-gnu
	# dockerfile lint
	curl -LZ -o ~/.local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.6.0/hadolint-Linux-x86_64 && chmod a+rx ~/.local/bin/hadolint


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
	go install filippo.io/mkcert

tools/fedora:
	sudo install -y copyq

devel/fedora:
	# or sudo dnf builddep neovim
	# compat-lua is lua5.1
	sudo dnf groupinstall -y "Development Tools" "Development Libraries"
	sudo dnf install -y cmake ninja-build gcc-c++ libtool

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
	go install github.com/gsamokovarov/jump
	# https://github.com/ayoisaiah/f2#installation
	go install -u github.com/ayoisaiah/f2/cmd/...
	# The power of curl, the ease of use of httpie. https://github.com/rs/curlie
	go install -u github.com/rs/curlie
	# It's like curl -v, with colours. https://github.com/davecheney/httpstat
	go install github.com/davecheney/httpstat
	# convert csv/tsv to markdown table https://github.com/monochromegane/mdt
	go install github.com/monochromegane/mdt/...

tools/cloud:
	go install github.com/juliosueiras/nomad-lsp
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

# for ArchLinux you need to unset lua5.4 env vars
# because it belongs to lua 5.4 which will mess the build (make neovim link to the wrong lpeg.so)
# eval "$(luarocks --lua-version 5.1 path --bin)"
# nvim: export LUA_CPATH=/home/ttys3/.config/nvim/neovim/.deps/usr/lib/lua/5.1/?.so;/home/ttys3/.luarocks/lib64/lua/5.1/?.so
# unset LUAROCKS_CONFIG LUA_PATH LUA_CPATH
unexport LUAROCKS_CONFIG
unexport LUA_PATH
unexport LUA_CPATH
nvim:
	test -d neovim || git clone https://github.com/neovim/neovim.git
	# https://github.com/ninja-build/ninja/issues/1302
	sudo chown -R $$USER:$$GROUP ./neovim
	# https://github.com/neovim/neovim/wiki/Building-Neovim#building
	# Do not add a -j flag if ninja is installed! The build will be in parallel automatically.
	test -d neovim && cd neovim && git pull origin master --tags --force && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install && cd ../ && nvim --version


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
	nvim --startuptime startup.log -c ":q" && cat startup.log && rm -f startup.log

plugtime:
	nvim --startuptime startup.log -c ":q" && cat startup.log | sort -k2 && rm -f startup.log

debug:
	- rm -f bat /tmp/nvim.log
	nvim -V10/tmp/nvim.log
	bat /tmp/nvim.log
