FROM ubuntu:hirsute-20210711 as base

ENV TZ=Asia/Shanghai \
    LANG=en_US.UTF-8

WORKDIR /

RUN set -eux; \
  \
  echo "current architecture is: $(dpkg --print-architecture)"; \
  apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates tzdata; \
  update-ca-certificates -f; \
  ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime; \
  sed -i.bak 's|http://archive.ubuntu.com|https://mirrors.tuna.tsinghua.edu.cn|g' /etc/apt/sources.list; \
  sed -i 's|http://security.ubuntu.com|https://mirrors.tuna.tsinghua.edu.cn|g' /etc/apt/sources.list; \
  apt-get update; \
  \
# ls for human
# Bash login shells run only /etc/profile
# Bash non-login shells run only /etc/bashrc
{ \
  echo "alias l='ls -CF'"; \
    echo "alias la='ls -A'"; \
    echo "alias ll='ls -alhp'"; \
    echo "alias ls='ls --color=auto'"; \
    echo 'export EDITOR=nvim'; \
} >> /root/.bashrc; \
  \
{ \
  echo "alias l='ls -CF'"; \
    echo "alias la='ls -A'"; \
    echo "alias ll='ls -alhp'"; \
    echo "alias ls='ls --color=auto'"; \
    echo 'export EDITOR=nvim'; \
} >> /etc/skel/.bashrc


# ------------------------------------------------------------------------------ #
FROM base as builder

RUN set -eux; \
      \
# build neovim libluajit-5.1-dev \
      DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      git gcc g++ cmake make automake autoconf pkg-config clang \
      libtool libtool-bin gettext libgettextpo-dev \
      unzip bzip2 curl \
      python3-dev \
      python3-pip \
      libssl-dev \
      libffi-dev

RUN set -eux; \
      \
      git clone https://github.com/neovim/neovim.git /tmp/neovim

RUN set -eux; \
      \
      cd /tmp/neovim; \
      rm -rf ~/.cache/luarocks; \
      CC=clang make CMAKE_EXTRA_ARGS=-DCLANG_ASAN_UBSAN=ON -j$(nproc); \
      mkdir /build ; \
      make DESTDIR=/build install

# ------------------------------------------------------------------------------ #

FROM base as runtime

COPY --from=builder /build/ /

COPY . /root/.config/nvim

# nvim-treesitter needs gcc, g++ and libstdc++
RUN set -eux; \
  apt-get update; \
  apt-get install -y --no-install-recommends xclip curl python3 python3-pip git; \
  apt-get install -y --no-install-recommends libluajit-5.1-dev liblua5.1-0-dev; \
  apt-get install -y --no-install-recommends gdb gcc g++ libstdc++-10-dev; \
  pip3 install --user pynvim

RUN set -eux; \
  git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim

WORKDIR /root/.config/nvim

# RUN set -eux; \
  # env PACKER_NON_INTERACTIVE=1 nvim -i NONE -c "lua require('packer').install()" -c "PackerCompile"


