

debug info for fixup lsp goimports took from https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports

```lua
local out_result = {
	{
		result = {
			{
				edit = {
					documentChanges = {},
				},
				kind = "source.organizeImports",
				title = "Organize Imports",
			},
			{
				command = {
					arguments = {
						{
							Fix = "fill_struct",
							Range = {},
							URI = "file:///home/ttys3/work/foo.go",
						},
					},
					command = "gopls.apply_fix",
					title = "Fill pb_moment.ReqBody",
				},
				edit = vim.empty_dict(),
				kind = "refactor.rewrite",
				title = "Fill pb_moment.ReqBody",
			},
			{
				command = {
					arguments = {
						{
							Fix = "fill_struct",
							Range = {},
							URI = "file:///home/ttys3/work/foo.go",
						},
					},
					command = "gopls.apply_fix",
					title = "Fill pb_moment.FeaturedCondition",
				},
				edit = vim.empty_dict(),
				kind = "refactor.rewrite",
				title = "Fill pb_moment.FeaturedCondition",
			},
		},
	},
}
```
