map { "p", "<Plug>(miniyank-autoput)" }
map { "P", "<Plug>(miniyank-autoPut)" }
map { "<leader>n", "<Plug>(miniyank-cycle)" }
map { "<leader>N", "<Plug>(miniyank-cycleback)" }
-- " the standard "+gP and "+y commands very difficult to use
vmap { "<RightMouse>", '"+y' }
vmap { "<leader>yy", '"+y' }
nnoremap { "<C-y>", '"+y' }
vnoremap { "<C-y>", '"+y' }
nnoremap { "<C-p>", '"+gP' }
vnoremap { "<C-p>", '"+gP' }
-- " make Y consistent with C and D. See :help Y.
nnoremap { "Y", "y$" }
