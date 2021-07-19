" this file is not intened for working with DOS version ini

" fixup comment syntax for common used ini file (not for dos ini)
syn match  dosiniComment  "^\s*[#;].*$"

" set commentstring for common used ini file (not for dos ini)
setlocal commentstring=#\ %s
