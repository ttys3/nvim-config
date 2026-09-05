# nvim-config

https://github.com/ttys3/nvim-config

Lua Neovim config for **Nvim 0.12.5+** (tracks **0.13** when installable). Works on **Fedora 44+** and **macOS 26+**.

- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim) (not `vim.pack`)
- Completion: builtin `vim.lsp.completion` + `'autocomplete'` + `vim.snippet` (accept with **CTRL-Y**; Tab/S-Tab jump snippets)
- LSP: `vim.lsp.config` / `vim.lsp.enable` + `lsp/*.lua`; [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) is a data pack only
- Treesitter: `nvim-treesitter` **main** (`install` + `vim.treesitter.start`)
- File tree: neo-tree (not `filetype=directory`)

See [docs/2026-09-06_032425-neovim-0.13-config.md](docs/2026-09-06_032425-neovim-0.13-config.md) for 0.10–0.13 API notes and plugin keep/drop.

## Requirements

- Neovim 0.12.5 or newer (`nvim -v`)
- `git`, `python3` on `PATH` (Homebrew or `/usr/bin`)
- Optional: `rg`, `lua-language-server`, `stylua`, `gopls`, `fcitx5-remote` (Linux IME only)

## Install

```sh
git clone https://github.com/ttys3/nvim-config.git $HOME/.config/nvim
nvim --headless "+Lazy! sync" "+qa"
```

First GUI start also bootstraps lazy.nvim.

### Fedora 44+

```sh
sudo dnf install -y neovim python3-neovim ripgrep fd-find stylua
# language servers as needed:
# sudo dnf install -y lua-language-server
```

### macOS 26+

```sh
brew install neovim ripgrep fd stylua lua-language-server
```

Do not hardcode `/opt/homebrew` vs `/usr/local`; keep tools on `PATH`.

### stylua (if not packaged)

Download a release for your OS/arch and put `stylua` on `PATH` (e.g. `~/.local/bin` or Homebrew).

## Language tools

```sh
make lang/rust
make lang/go
make lang/lua
make lang/php
```

`INTELEPHENSE_LICENCE_KEY` may be set in the shell if you have a key.

## Usage notes

| Keys | Action |
| --- | --- |
| `gcc` / `gc` | Comment (builtin) |
| `grn` / `gra` / `grr` / `grt` / `grx` | Rename / code action / references / type / codelens |
| `gd` / `K` | Definition / hover |
| `CTRL-Y` | Accept completion |
| `CTRL-S` | Signature help (insert) |
| `Q` | Nvim 0.13 multicursor (not macro replay) |
| `<leader>f` | Neo-tree |
| `<leader><leader>` | Telescope files |

Hop still uses `phaazon/hop.nvim` v2 (archived). A later swap to `smoka7/hop.nvim` is optional.

Experimental Nvim 0.13 UI is commented in `lua/core/options.lua` (`vim._core.ui2`).

## Fonts

A [Nerd Font](https://github.com/ryanoasis/nerd-fonts) is required for icons.

## Check

```sh
nvim --headless "+checkhealth vim.lsp" "+qa"
```
