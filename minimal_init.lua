-- Obsolete Packer-based LSP scratch file.
-- Use the main config (init.lua + lua/lsp/attach.lua + lsp/*.lua) instead.
--
-- Minimal gopls smoke test without lazy.nvim:
--   nvim -u NONE --cmd "lua vim.lsp.enable('gopls')" file.go

vim.notify("minimal_init.lua is obsolete; use ~/.config/nvim/init.lua", vim.log.levels.WARN)
