map { "p", "<Plug>(miniyank-autoput)" }
map { "P", "<Plug>(miniyank-autoPut)" }
map { "<leader>n", "<Plug>(miniyank-cycle)" }
map { "<leader>N", "<Plug>(miniyank-cycleback)" }
-- " the standard "+gP and "+y commands very difficult to use
vmap { "<RightMouse>", '"+y' }
vmap { "<leader>yy", '"+y' }
nnoremap { "<leader>y", '"+y' }
vnoremap { "<leader>y", '"+y' }
nnoremap { "<leader>p", '"+gP' }
vnoremap { "<leader>p", '"+gP' }
-- " make Y consistent with C and D. See :help Y.
nnoremap { "Y", "y$" }

