-- keymap from https://neovim.io/doc/user/lsp.html
-- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
nnoremap { "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", silent = true }

nnoremap { "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", silent = true }
-- nnoremap { "<C-LeftMouse>", "<Cmd>lua vim.lsp.buf.definition()<CR>", silent = true }
nnoremap { "<2-LeftMouse>", "<Cmd>lua vim.lsp.buf.definition()<CR>", silent = true }
nnoremap { "<C-RightMouse>", "<C-O>", silent = true }
nnoremap { "<LeftMouse><RightMouse>", "<C-O>", silent = true }
nnoremap { "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", silent = true }
nnoremap { "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent = true }
nnoremap { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", silent = true }
nnoremap { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", silent = true }
nnoremap { "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", silent = true }
nnoremap { "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", silent = true }
nnoremap { "<Leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", silent = true }
nnoremap { "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", silent = true }
nnoremap { "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", silent = true }
-- lspsaga currently can not popup with current name of the symbol in the popup
-- https://github.com/glepnir/lspsaga.nvim/issues/186
-- nnoremap <silent> <F2> <cmd>lua require('lspsaga.rename').rename()<CR>
-- nnoremap { "<space>ee", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({ border = 'single' })<CR>", silent = true }
-- open all diagnostics
nnoremap { "<space>ee", "<cmd>lua vim.diagnostic.setloclist()<CR>", silent = true }
-- toggle diagnostics loclist, open loclist if there are diagnostics severity >= WARN, else show a notify info. if loclist open, close it
-- nnoremap { "<space>e", "<cmd>lua vim.diagnostic.setloclist({severity = vim.diagnostic.severity.WARN})<CR>", silent = true }
nnoremap {
	"<space>e",
	function()
		local loc = vim.fn.getloclist(0)
		if loc and type(loc) == "table" and #loc > 0 then
			-- close the loclist
			vim.api.nvim_command "lclose"
			-- clear the loclist
			vim.fn.setloclist(0, {})
			-- require "notify" "close diagnostics loclist."
			return
		end
		-- severity_limit: "Warning" means { "Error", "Warning" } will be valid.
		-- see https://github.com/neovim/neovim/blob/b3b02eb52943fdc8ba74af3b485e9d11655bc9c9/runtime/lua/vim/lsp/diagnostic.lua#L646
		local diag = vim.diagnostic.get(0, { severity_limit = vim.diagnostic.severity.WARN })
		if diag and type(diag) == "table" and #diag > 0 then
			vim.diagnostic.setloclist { severity_limit = vim.diagnostic.severity.WARN }
		else
			require "notify" "no diagnostics meet the severity level >= warn."
		end
	end,
	silent = true,
}

nnoremap { "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", silent = true }
nnoremap { "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", silent = true }

-- ga has been mapped to vim-easy-align
-- commentary took gc and gcc, so ...
-- lsp builtin code_action
nnoremap { "ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent = true }
nnoremap { "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent = true }
vnoremap { "ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", silent = true }
vnoremap { "<leader>a", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", silent = true }

-- lspsaga code action
-- nnoremap { "ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", silent = true }
-- vnoremap { "ca", "<cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<CR>", silent = true }
-- preview definition
-- nnoremap { "<leader>K", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>", silent = true }

-- https://github.com/neovim/neovim/pull/16057
-- https://www.reddit.com/r/neovim/comments/qd3v4h/psa_vimdiagnostics_api_has_changed_a_little_bit/hhl1pbh/
-- nnoremap <leader>dn <cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>
nnoremap { "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", silent = true }
nnoremap { "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", silent = true }

-- lspsaga
-- lsp provider to find the cursor word definition and reference
nnoremap { "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", silent = true }

require "lsp.nomadls"

local lsp = require "lspconfig"

require("lsp").setup_diagnostic_sign()
require("lsp").setup_item_kind_icons()
require("lsp").setup_lsp_doc_border()

-- nvim-cmp related config
-- https://github.com/hrsh7th/cmp-nvim-lsp/issues/38#issuecomment-1279744539
local capabilities = require("cmp_nvim_lsp").default_capabilities()

--@param client: (required, vim.lsp.client)
local mix_attach = function(client)
	-- force enable yamlls formatting feature
	-- see https://github.com/redhat-developer/yaml-language-server/issues/486#issuecomment-1046792026
	if client.name == "yamlls" then
		-- Accessing client.resolved_capabilities is deprecated, update your plugins or configuration
		-- to access client.server_capabilities instead.
		-- The new key/value pairs in server_capabilities directly match those defined in the language server protocol
		client.server_capabilities.document_formatting = true
	end

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
	single_file_support = true,
	settings = {
		gopls = {
			usePlaceholders = true,
			completeUnimported = true,
			-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md#gofumpt-bool
			-- https://github.com/mvdan/gofumpt/commit/38fc491470bae6f44e2d38b06277dd95cf1bdf97
			-- https://go-review.googlesource.com/c/tools/+/241985/7/gopls/internal/hooks/hooks.go#22
			gofumpt = true,
			staticcheck = true,
			templateExtensions = {},
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
	capabilities = capabilities,
}

-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports
function _G.go_org_imports(options)
	options = options or {}
	local timeout_ms = options.timeout_ms or 1000
	-- we only need source.organizeImports
	-- see runtime/lua/vim/lsp/buf.lua code_action()
	-- see https://github.com/golang/tools/commit/6e9046bfcd34178dc116189817430a2ad1ee7b43
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	for cid, res in pairs(result or {}) do
		for _, r in pairs(res.result or {}) do
			if r.edit then
				local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
				vim.lsp.util.apply_workspace_edit(r.edit, enc)
			else
				vim.lsp.buf.execute_command(r.command)
			end
		end
	end
end

-- https://github.com/neovim/nvim-lspconfig/issues/115
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = vim.lsp.buf.format,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = go_org_imports,
})

-- https://clangd.llvm.org/features.html
lsp.clangd.setup {
	-- remove support to proto due to includes error
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
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

local rust_lsp_options = {
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

-- override by rust-tools setup
-- so we do not need setup here
-- lsp.rust_analyzer.setup(rust_lsp_options)

require("rust-tools").setup {
	-- rust-tools options
	tools = {
		-- default: true
		autoSetHints = true,
	},

	-- rust-tools will call: rust_analyzer.setup(config.options.server)
	-- all the opts to send to nvim-lspconfig
	-- these override the defaults set by rust-tools.nvim
	-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
	-- rust-analyer options
	server = rust_lsp_options,
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua
-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.getenv "HOME" .. "/.local/share/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

lsp.sumneko_lua.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
	log_level = vim.lsp.protocol.MessageType.Log,
	message_level = vim.lsp.protocol.MessageType.Log,
	-- https://github.com/LuaLS/lua-language-server/wiki/Setting-without-VSCode#neovim-with-built-in-lsp-client
	-- https://github.com/LuaLS/lua-language-server/blob/7a63f98e41305e8deb114164e86a621881a5a2bc/script/config.lua#L96
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
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
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

-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tailwindcss
lsp.tailwindcss.setup {}

-- custom lsp config
lsp.nomadls.setup {
	on_attach = mix_attach,
	capabilities = capabilities,
}

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
	pattern = { "*.go", "*.rs", "*.lua", "*.c", "*.cpp", "*.py", "*.php", "*.{yaml,yml}" },
	callback = function(opts)
		opts = opts or {}
		opts.id = nil
		-- dump(opts)
		vim.lsp.buf.format(opts)
	end,
})
