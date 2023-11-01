#!/usr/bin/env bash

touch ~/.cache/nvim/lsp.log
truncate -s 0 ~/.cache/nvim/lsp.log
tail -f ~/.cache/nvim/lsp.log
