-- keymap from https://neovim.io/doc/user/lsp.html
-- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
nnoremap { "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", silent = true }

nnoremap { "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", silent = true }
nnoremap { "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", silent = true }
nnoremap { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent = true }
nnoremap { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", silent = true }
nnoremap { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", silent = true }
nnoremap { "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", silent = true }
nnoremap { "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", silent = true }
nnoremap { "<Leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", silent = true }
nnoremap { "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", silent = true }
nnoremap { "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", silent = true }
nnoremap { "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", silent = true }
-- lspsaga currently can not popup with current name of the symbol in the popup
-- https://github.com/glepnir/lspsaga.nvim/issues/186
-- nnoremap <silent> <F2> <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap { "<space>ee", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", silent = true }
-- open diagnostic
nnoremap { "<space>e", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", silent = true }

nnoremap { "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", silent = true }
nnoremap { "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", silent = true }

-- ga has been mapped to vim-easy-align
-- commentary took gc and gcc, so ...
-- lsp builtin code_action
nnoremap { "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent = true }
vnoremap { "ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", silent = true }

-- lspsaga code action
-- nnoremap { "ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", silent = true }
-- vnoremap { "ca", "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>", silent = true }
-- preview definition
-- nnoremap { "<leader>K", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", silent = true }

-- diag https://github.com/nvim-lua/diagnostic-nvim/issues/73
-- nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>
nnoremap { "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", silent = true }
nnoremap { "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", silent = true }

-- lspsaga
-- lsp provider to find the cursor word definition and reference
nnoremap { "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", silent = true }

local lsp = require "lspconfig"

require("lsp").setup_diagnostic_sign()
require("lsp").setup_item_kind_icons()

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- by default, NeoVim lsp disabled snippet, see https://github.com/neovim/neovim/pull/13183
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

--@param client: (required, vim.lsp.client)
local mix_attach = function(client)
	-- require("lsp").set_lsp_omnifunc()
	local has_illuminate, illuminate = pcall(require, "illuminate")
	if has_illuminate then
		illuminate.on_attach(client)
	end

	local has_lsp_signature, lsp_signature = pcall(require, "lsp_signature")
	if has_lsp_signature then
		local cfg = {
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			-- If you want to hook lspsaga or other signature handler, pls set to false
			doc_lines = 10, -- only show one line of comment set to 0 if you do not want API comments be shown

			hint_enable = true, -- virtual hint enable
			hint_prefix = "🐼 ", -- Panda for parameter
			hint_scheme = "String",

			handler_opts = {
				border = "shadow", -- double, single, shadow, none
			},
			decorator = { "`", "`" }, -- or decorator = {"***", "***"}  decorator = {"**", "**"} see markdown help
		}
		lsp_signature.on_attach(cfg)
	end
end

lsp.bashls.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

-- php
lsp.intelephense.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
	--[[
                    cmd_env = {
                        https_proxy = 'http://127.0.0.1:8888',
                        http_proxy = 'http://127.0.0.1:8888',
                    },
                --]]
	trace = "verbose",
	-- root_dir = root_pattern("composer.json", ".git"),
	init_options = {
		-- See https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#initialisation-options
		-- Optional absolute path to storage dir. Defaults to os.tmpdir()
		storagePath = "/tmp/intelephense",
		-- Optional absolute path to a global storage dir. Defaults to os.homedir()
		globalStoragePath = os.getenv "HOME" .. "/.cache/intelephense",
		--  Optional licence key or absolute path to a text file containing the licence key.
		-- {os.homedir()}/intelephense/licence.txt will also be checked by default
		-- if initializationOptions are not exposed by client.
		licenceKey = os.getenv "INTELEPHENSE_LICENCE_KEY" or "",
		-- clearCache = Optional flag to clear server state. State can also be cleared by deleting {storagePath}/intelephense
	},
	settings = {
		-- see https://github.com/bmewburn/intelephense-docs/blob/master/gettingStarted.md
		intelephense = {
			files = {
				-- Maximum file size in bytes
				maxSize = 5000000,
			},
			environment = {
				phpVersion = "7.4.0",
			},
		},
	},
}

lsp.dockerls.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

-- lsp.gopls.setup{}
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/gopls.lua
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#gopls
lsp.gopls.setup {
	on_attach = mix_attach,
	settings = {
		gopls = {
			usePlaceholders = true,
			completeUnimported = true,
			allowModfileModifications = true,
			allowImplicitNetworkAccess = true,
			-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#gofumpt-bool
			-- https://github.com/mvdan/gofumpt/commit/38fc491470bae6f44e2d38b06277dd95cf1bdf97
			-- https://go-review.googlesource.com/c/tools/+/241985/7/gopls/internal/hooks/hooks.go#22
			gofumpt = true,
			-- Postfix completion snippets https://github.com/golang/tools/blob/master/gopls/doc/settings.md#experimentalpostfixcompletions-bool
			experimentalPostfixCompletions = true,
			-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#expandworkspacetomodule-bool
			expandWorkspaceToModule = true,
			experimentalTemplateSupport = true,
		},
	},
	capabilities = capabilities,
}

-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
function _G.goimports(timeout_ms)
	-- source.organizeImports
	local context = { source = { organizeImports = true } }
	vim.validate { context = { context, "t", true } }

	local params = vim.lsp.util.make_range_params()
	params.context = context

	-- See the implementation of the textDocument/codeAction callback
	-- (lua/vim/lsp/handler.lua) for how to do this properly.
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	if not result or next(result) == nil then
		return
	end
	local actions = result[1].result
	if not actions then
		return
	end
	local action = actions[1]

	-- textDocument/codeAction can return either Command[] or CodeAction[]. If it
	-- is a CodeAction, it can have either an edit, a command or both. Edits
	-- should be executed first.
	if action.edit or type(action.command) == "table" then
		if action.edit then
			vim.lsp.util.apply_workspace_edit(action.edit)
		end
		if type(action.command) == "table" then
			vim.lsp.buf.execute_command(action.command)
		end
	else
		vim.lsp.buf.execute_command(action)
	end
end
-- vim.api.nvim_command('autocmd BufWritePre *.go lua goimports(1000)')

-- https://clangd.llvm.org/features.html
lsp.clangd.setup {
	init_options = {
		clangdFileStatus = true,
	},
	on_attach = mix_attach,
	capabilities = capabilities,
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#ccls
-- https://github.com/MaskRay/ccls/wiki
-- lsp.ccls.setup {
--   init_options = {
-- 	  compilationDatabaseDirectory = "build";
--     index = {
--       threads = 0;
--     };
--     clang = {
--       excludeArgs = { "-frounding-math"} ;
--     };
--   }
-- }

-- lsp.pyright.setup{}
lsp.pyright.setup {
	settings = { python = { workspaceSymbols = { enabled = true } } },
	on_attach = mix_attach,
	capabilities = capabilities,
}

-- lsp.rust_analyzer.setup{}
lsp.rust_analyzer.setup {
	on_attach = mix_attach,
	capabilities = capabilities,

	settings = {
		-- https://rust-analyzer.github.io/manual.html#configuration
		-- https://rust-analyzer.github.io/manual.html#nvim-lsp
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "by_self",
			},
			cargo = {
				loadOutDirsFromCheck = true,
			},
			-- rust-analyzer.procMacro.enable
			procMacro = {
				enable = true,
			},
			lruCapacity = 1024,
			-- rust-analyzer.checkOnSave.command": "clippy"
			checkOnSave = {
				enable = true,
				command = "clippy",
			},
		},
	},
}

require("rust-tools").setup {
	-- automatically set inlay hints (type hints)
	-- There is an issue due to which the hints are not applied on the first
	-- opened file. For now, write to the file to trigger a reapplication of
	-- the hints or just run :RustSetInlayHints.
	-- default: true
	autoSetHints = true,
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua
-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local system_name
if vim.fn.has "mac" == 1 then
	system_name = "macOS"
elseif vim.fn.has "unix" == 1 then
	system_name = "Linux"
elseif vim.fn.has "win32" == 1 then
	system_name = "Windows"
else
	print "Unsupported system for sumneko"
end
local sumneko_root_path = vim.fn.getenv "HOME" .. "/.local/share/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

lsp.sumneko_lua.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
	log_level = vim.lsp.protocol.MessageType.Log,
	message_level = vim.lsp.protocol.MessageType.Log,
	-- https://github.com/sumneko/lua-language-server/wiki/Setting-without-VSCode#neovim-with-built-in-lsp-client
	-- https://github.com/sumneko/lua-language-server/blob/7a63f98e41305e8deb114164e86a621881a5a2bc/script/config.lua#L96
	cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "Lua 5.1",
				-- version = 'LuaJIT',
				-- path = vim.split(package.path, ';')
				path = {
					"?.lua",
					"?/init.lua",
					vim.fn.expand "~/.luarocks/share/lua/5.1/?.lua",
					vim.fn.expand "~/.luarocks/share/lua/5.1/?/init.lua",
					"/usr/share/lua/5.1/?.lua",
					"/usr/share/lua/5.1/?/init.lua",
				},
			},
			diagnostics = {
				enable = true,
				globals = { "vim", "describe", "it", "before_each", "after_each" },
			},
			workspace = {
				library = {
					[vim.fn.expand "$VIMRUNTIME/lua"] = true,
					[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
				},
				maxPreload = 3000, -- default 1000
				preloadFileSize = 1024, -- default 100 ( KiB )
			},
		},
	}, -- end settings
}

lsp.tsserver.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

lsp.denols.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#vala_ls
-- meson improvement has been merged:
-- https://github.com/neovim/nvim-lspconfig/pull/789

lsp.vala_ls.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
	cmd = { "vala-language-server" },
}

lsp.vimls.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

lsp.vuels.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

lsp.html.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

lsp.cssls.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

lsp.jsonls.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

lsp.yamlls.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

lsp.nomadls.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

-- Use LSP omni-completion

Augroup {
	LspBufWritePre = {
		-- " autocmd BufWritePre *.go execute '!gofmt %' | edit
		-- " autocmd BufWritePre *.go execute '!goimports -w -v -srcdir %' | edit
		-- " https://www.rockyourcode.com/til-how-to-execute-an-external-command-in-vim-and-reload-the-file/
		-- " autocmd BufWritePre *.go :%!goimports -srcdir %
		-- " nmap <Leader>gi :%!goimports -srcdir %<CR>
		-- " nmap <Leader>gf :%!gofumpt -s %<CR>
		["BufWritePre"] = {
			{ "*.lua", require("lsp").formatting_sync },
			{ "*.c", require("lsp").formatting_sync },
			{ "*.go", require("lsp").formatting_sync },
			{ "*.rs", require("lsp").formatting_sync },
			{ "*.py", require("lsp").formatting_sync },
			{ "*.php", require("lsp").formatting_sync },
			-- { "*.js", require("lsp").formatting_sync },
		},
	},
}
