Variable.g {
	-- " disable header folding
	vim_markdown_folding_disabled = 1,
	-- " do not use conceal feature, the implementation is not so good
	-- " let g:vim_markdown_conceal = 0
	-- disable math tex conceal feature
	-- let g:tex_conceal = ""
	vim_markdown_math = 1,
	-- support front matter of various format
	vim_markdown_frontmatter = 1, -- for YAML format
	vim_markdown_toml_frontmatter = 1, -- for TOML format
	vim_markdown_json_frontmatter = 1, -- for JSON format
}
