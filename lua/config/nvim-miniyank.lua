local map = vim.keymap.set

map("", "p", "<Plug>(miniyank-autoput)", { remap = true })
map("", "P", "<Plug>(miniyank-autoPut)", { remap = true })
map("", "<leader>n", "<Plug>(miniyank-cycle)", { remap = true })
map("", "<leader>N", "<Plug>(miniyank-cycleback)", { remap = true })
map("v", "<RightMouse>", '"+y')
map("v", "<leader>yy", '"+y')
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>p", '"+gP')
map("v", "<leader>p", '"+gP')
map("n", "Y", "y$")
