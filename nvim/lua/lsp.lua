require("lspconfig")
vim.lsp.enable({
	"clangd",
	"cssls",
	"denols",
	"denols_markdown",
	"elixirls",
	"emmet_language_server",
	"eslint",
	"gopls",
	"harper_ls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	"nixd",
	"pyright", -- TODO: replace with `ty`
	"ruff",
	"rust_analyzer",
	"sqls",
	"sqruff",
	"stylua",
	"tailwindcss",
	"taplo",
	"ts_ls",
	"ty",
	"typos_lsp",
	"yamlls",
	-- "bashls",
	-- "copilot", -- TODO: enable when supported
	-- "expert", -- TODO: replace `elixirls`
	-- "ltex_plus",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		-- Completion
		if client.server_capabilities.completionProvider then
			vim.keymap.set("i", "<C-space>", vim.lsp.completion.get)

			-- Add additional trigger characters
			if client.server_capabilities.completionProvider.triggerCharacters then
				vim.list_extend(
					client.server_capabilities.completionProvider.triggerCharacters,
					vim.split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRTUVWXYZ", "")
				)
			end

			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		-- Formatting and stuff on save
		-- This could be simplified a lot with good LSP servers
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = args.buf,
			callback = function()
				if client.server_capabilities.codeActionProvider and client.name == "eslint" then
					vim.lsp.buf.code_action({
						context = {
							only = { "source.fixAll" }, -- only use source.fixAll for eslint.(it prints an annoying message otherwise)
							diagnostics = {},
							triggerKind = 2,
						},
						apply = true,
						bufnr = args.buf,
					})
				end

				-- Actual formatting
				if
					client.server_capabilities.documentFormattingProvider
					and client.name ~= "ts_ls"
					and client.name ~= "lua_ls"
					and client.name ~= "sqls"
				then
					vim.lsp.buf.format({
						bufnr = args.buf,
						id = client.id,
						timeout_ms = 1000,
					})
				end
			end,
		})

		-- TODO: enable when supported in neovim 0.12
		-- if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, args.buf) then
		-- 	vim.lsp.inline_completion.enable(true, { bufnr = args.buf })
		-- 	vim.keymap.set(
		-- 		"i",
		-- 		"<C-F>",
		-- 		vim.lsp.inline_completion.get,
		-- 		{ desc = "LSP: accept inline completion", buffer = args.buf }
		-- 	)
		-- 	vim.keymap.set(
		-- 		"i",
		-- 		"<C-G>",
		-- 		vim.lsp.inline_completion.select,
		-- 		{ desc = "LSP: switch inline completion", buffer = args.buf }
		-- 	)
		-- end
	end,
})
