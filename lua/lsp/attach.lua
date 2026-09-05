-- LSP attach: builtin completion, inlay, codelens, format, Go imports.
-- Default Nvim maps: grn/grr/gra/gri/grt/grx, gO, CTRL-S, K, [d ]d.
-- Do not map `gr` — it steals the gr* prefix.

local map = vim.keymap.set

local function client_supports(client, method)
	if client.supports_method then
		return client:supports_method(method)
	end
	return client.server_capabilities and client.server_capabilities[method]
end

local function organize_go_imports(opts)
	opts = opts or {}
	local timeout_ms = opts.timeout_ms or 1000
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "gopls" })
	for _, client in ipairs(clients) do
		local enc = client.offset_encoding or "utf-16"
		local params = vim.lsp.util.make_range_params(0, enc)
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, timeout_ms)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local c = vim.lsp.get_client_by_id(cid)
					local edit_enc = (c and c.offset_encoding) or enc
					vim.lsp.util.apply_workspace_edit(r.edit, edit_enc)
				elseif r.command then
					if client.exec_cmd then
						client:exec_cmd(r.command, { bufnr = bufnr })
					end
				end
			end
		end
	end
end

vim.lsp.config("*", {
	capabilities = vim.lsp.protocol.make_client_capabilities(),
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local bufnr = ev.buf
		if not client then
			return
		end

		local opts = { buffer = bufnr, silent = true }

		if client_supports(client, "textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
		end

		if vim.lsp.codelens and vim.lsp.codelens.enable and client_supports(client, "textDocument/codeLens") then
			vim.lsp.codelens.enable(true, bufnr)
		end

		if client_supports(client, "textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
		end

		if client.name == "yamlls" then
			client.server_capabilities.documentFormattingProvider = true
		end

		-- Extra maps that do not steal gr*
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		map("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		map("n", "<Leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		map("n", "<Leader>D", vim.lsp.buf.type_definition, opts)
		map("n", "<F2>", vim.lsp.buf.rename, opts)
		map("n", "g0", vim.lsp.buf.document_symbol, opts)
		map("n", "gW", vim.lsp.buf.workspace_symbol, opts)
		map({ "n", "v" }, "ca", vim.lsp.buf.code_action, opts)
		map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
		map("n", "<leader>c", vim.lsp.codelens.run, opts)
		map("n", "<2-LeftMouse>", vim.lsp.buf.definition, opts)
		map("n", "<C-RightMouse>", "<C-O>", opts)
		map("n", "<LeftMouse><RightMouse>", "<C-O>", opts)

		map("n", "<space>ee", vim.diagnostic.setloclist, opts)
		map("n", "<space>e", function()
			local loc = vim.fn.getloclist(0)
			if loc and type(loc) == "table" and #loc > 0 then
				vim.cmd("lclose")
				vim.fn.setloclist(0, {})
				return
			end
			local diag = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })
			if diag and #diag > 0 then
				vim.diagnostic.setloclist({ severity = { min = vim.diagnostic.severity.WARN } })
			else
				vim.notify("no diagnostics meet the severity level >= warn.")
			end
		end, opts)
	end,
})

-- LSP format for languages that are not handled by formatter.nvim.
-- Lua / hcl / nomad / proto stay on formatter.nvim (stylua, hclfmt, nomad fmt, clang-format).
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
	pattern = { "*.go", "*.rs", "*.c", "*.cpp", "*.py", "*.php", "*.yaml", "*.yml" },
	callback = function(ev)
		if vim.bo[ev.buf].filetype == "go" then
			organize_go_imports()
		end
		vim.lsp.buf.format({ bufnr = ev.buf })
	end,
})
