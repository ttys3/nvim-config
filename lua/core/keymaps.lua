-- Global keymaps. LSP buffer maps live in lua/lsp/attach.lua.
-- vim.keymap.set is noremap by default.

local map = vim.keymap.set

map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")
map("i", "JK", "<Esc>")
map("i", "KJ", "<Esc>")

map("n", "<leader>vs", "<C-w>v<C-w>l")
map("n", "<leader>hs", "<C-w>s")
map("n", "<leader>vsa", ":vert sba<cr>")

map("i", "<A-h>", "<Left>")
map("i", "<A-j>", "<Down>")
map("i", "<A-k>", "<Up>")
map("i", "<A-l>", "<Right>")

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<leader>lt", function()
	vim.wo.list = not vim.wo.list
end)

map("n", "<C-f5>", ":%!gomodifytags -all -add-tags toml,json -file %<CR>")
map("v", "tb", "c<C-R>=system('mdt', @\")<CR><ESC>")
map("v", "<leader>s", ":sort<cr>")

map("", "<leader>tn", ":tabnew<CR>")
map("", "<leader>tc", ":tabclose<CR>")

map("n", "<up>", ":bprev<CR>")
map("n", "<down>", ":bnext<CR>")
map("n", "<right>", ":tabnext<CR>")
map("n", "<left>", ":tabprev<CR>")
map("", "<leader>1", "1gt", { silent = true })
map("", "<leader>2", "2gt", { silent = true })
map("", "<leader>3", "3gt", { silent = true })
map("", "<leader>4", "4gt", { silent = true })
map("", "<leader>5", "5gt", { silent = true })
map("", "<leader>6", "6gt", { silent = true })
map("", "<leader>7", "7gt", { silent = true })
map("", "<leader>8", "8gt", { silent = true })
map("", "<leader>9", "9gt", { silent = true })
map("", "<leader>0", ":tabo<CR>", { silent = true })

map("i", "<C-h>", "<left>")
map("i", "<C-l>", "<right>")
map("i", "<C-u>", "<C-g>u<C-u>")

map("n", "/", "/\\v")
map("v", "/", "/\\v")
map("n", "?", "?\\v")
map("v", "?", "?\\v")
map("n", ":s/", ":s/\\v")

map("n", "q:", "q:i")
map("n", "q/", "q/i")
map("n", "q?", "q?i")

map("n", "zr", "zr:echo &foldlevel<cr>")
map("n", "zm", "zm:echo &foldlevel<cr>")
map("n", "zR", "zR:echo &foldlevel<cr>")
map("n", "zM", "zM:echo &foldlevel<cr>")

map("n", "n", "nzz", { silent = true })
map("n", "N", "Nzz", { silent = true })
map("n", "*", "*zz", { silent = true })
map("n", "#", "#zz", { silent = true })
map("n", "g*", "g*zz", { silent = true })
map("n", "g#", "g#zz", { silent = true })
map("n", "<C-o>", "<C-o>zz", { silent = true })
map("n", "<C-i>", "<C-i>zz", { silent = true })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-c>", "<C-c>:echo<cr>")
map("n", "<BS>", ':let @/=""<cr>')

map("n", "<leader>DD", ':exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>', { silent = true })
map("n", "<leader>DP", ':exe ":profile pause"<cr>', { silent = true })
map("n", "<leader>DC", ':exe ":profile continue"<cr>', { silent = true })
map("n", "<leader>DQ", ':exe ":profile pause"<cr>:noautocmd qall!<cr>', { silent = true })

map("", "<leader>x", ":qa!<CR>")
map("", "<leader>q", ":q<CR>")
map("", "<leader>W", ":w !sudo tee % > /dev/null")
map("n", "<leader>s", ":w<cr>")
map("n", "<leader>w", ":wq<cr>")
map("n", "<leader>wq", ":wq<cr>")

-- Nvim 0.13: Q starts multicursor (it no longer replays a register).
-- Do not map Q back to macro replay. To restore the old behavior, uncomment:
-- map("n", "Q", "@q")
