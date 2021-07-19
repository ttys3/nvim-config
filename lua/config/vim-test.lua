-- vim.g["test#strategy"] = "floaterm"
vim.g["test#go#runner"] = "richgo"
vim.g["test#go#gotest#options"] = "-v --count=1"
vim.g["test#go#richgo#options"] = "-v --count=1"

-- these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap { "t<C-n>", ":TestNearest<CR>" }

nmap { "t<C-f>", ":TestFile<CR>" }

nmap { "t<C-s>", ":TestSuite<CR>" }

nmap { "t<C-l>", ":TestLast<CR>" }
nmap { "t<C-g>", ":TestVisit<CR>" }
