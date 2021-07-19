vim.g.translator_window_type = "popup"
-- """ vim-translator Configuration
-- " Echo translation in the cmdline
nmap { "<silent>", "<Leader>tr <Plug>Translate" }
vmap { "<silent>", "<Leader>tr <Plug>TranslateV" }
-- " Display translation in a window
nmap { "<silent>", "<Leader>tw <Plug>TranslateW" }
vmap { "<silent>", "<Leader>tw <Plug>TranslateWV" }
-- " Replace the text with translation
-- "nmap <silent> <Leader>r <Plug>TranslateR
-- "vmap <silent> <Leader>r <Plug>TranslateRV
-- " Translate the text in clipboard
-- "nmap <silent> <Leader>x <Plug>TranslateX
