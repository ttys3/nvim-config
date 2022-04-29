-- https://github.com/delphinus/agrp.nvim/blob/main/lua/agrp.lua

local M = {}

local function is_vim_func_string(s)
	return type(s) == "string" and s:match "^[bwtglsav]:[_%d%w]+$"
end

local function create_autocmd(params)
	local event = params.event
	local opt = {
		pattern = params.pattern,
		once = params.once and true or false,
		nested = params.nested and true or false,
	}
	if type(params.cb_or_cmd) == "function" or is_vim_func_string(params.cb_or_cmd) then
		opt.callback = params.cb_or_cmd
	else
		opt.command = params.cb_or_cmd
	end
	vim.api.nvim_create_autocmd(event, opt)
end

local function manage_definitions(definitions, group)
	for key, definition in pairs(definitions) do
		vim.validate {
			definition = { definition, "table" },
		}
		-- When group is nil, it does not set augroup.
		if type(key) == "number" then
			-- Each definition has all params to set.
			-- {
			--   {'TextYankPost', ...},
			--   {'VimEnter', ...},
			-- }
			if #definition == 3 then
				-- ex. {'TextYankPost', '*', function() vim.highlight.on_yank{} end},
				create_autocmd {
					group = group,
					event = definition[1],
					pattern = definition[2],
					cb_or_cmd = definition[3],
				}
			elseif #definition == 4 then
				-- ex. {'VimEnter', '*', {'once'}, function() vim.cmd[[echo 'Hello, World!']] end},
				create_autocmd {
					group = group,
					event = definition[1],
					pattern = definition[2],
					once = definition[3].once,
					nested = definition[3].nested,
					cb_or_cmd = definition[4],
				}
			else
				error "each definition should have 3 values (+options (once, nested))"
			end
		else
			-- One event has many definitions
			-- {
			--   ['BufNewFile,BufRead'] = {
			--     {'*.hoge', 'set filetype=hoge'},
			--     {'*.fuga', 'set filetype=fuga'},
			--   },
			-- }
			for _, d in ipairs(definition) do
				if #d == 2 then
					create_autocmd {
						group = group,
						event = key,
						pattern = d[1],
						cb_or_cmd = d[2],
					}
				elseif #d == 3 then
					create_autocmd {
						group = group,
						event = key,
						pattern = d[1],
						once = d[2].once,
						nested = d[2].nested,
						cb_or_cmd = d[3],
					}
				else
					error "each definition should have 2 values (+options (once, nested))"
				end
			end
		end
	end
end

M.set = function(groups)
	vim.validate { groups = { groups, "table" } }
	for name, definitions in pairs(groups) do
		vim.validate {
			definitions = { definitions, "table" },
		}
		if type(name) == "number" then
			-- This section deals with the pattern that has no augroup.
			--   require'agrp'.set{
			--     {
			--       ['BufNewFile,BufRead'] = {
			--         {'*.hoge', 'set filetype=hoge'},
			--       },
			--     },
			--   }
			manage_definitions(definitions)
		else
			-- This is for the usual pattern that has augroup.
			--   require'agrp'.set{
			--     MyFavorites = {
			--       {'QuickFixCmdPost', '*grep*', 'cwindow'},
			--     },
			--   }
			vim.api.nvim_create_augroup(name, {})
			manage_definitions(definitions, name)
		end
	end
end

return M
