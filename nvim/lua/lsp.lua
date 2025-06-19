require("lspconfig")
vim.lsp.enable({
	"bashls",
	"cssls",
	"emmet_language_server",
	"gopls",
	"harper_ls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	"nixd",
	"pyright",
	"ruff",
	"rust_analyzer",
	"sqls",
	-- "sqruff",
	"taplo",
	"ts_ls",
	"eslint",
	"ty",
	"typos_lsp",
	"yamlls",
	-- "ltex_plus",
})

vim.api.nvim_create_autocmd("LspAttach", {
	-- group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
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

		-- Inlay Hints
		if client.server_capabilities.inlayHintProvider then
			vim.keymap.set("n", "<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end)
		end

		-- Autoformatting ( for now I use Conform instead)
		-- if client.server_capabilities.documentFormattingProvider then
		-- 	vim.api.nvim_create_autocmd("BufWritePre", {
		-- 		pattern = "*",
		-- 		callback = function()
		-- 			vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
		-- 		end,
		-- 	})
		-- end

		-- Highlight current item
		if client.server_capabilities.documentHighlightProvider then
			vim.keymap.set("n", "g*", vim.lsp.buf.document_highlight)
			vim.keymap.set("n", "<Esc>", function()
				vim.cmd("nohlsearch")
				vim.lsp.buf.clear_references()
			end)
		end
		-- Auto highlight current item(similar to vscode)
		-- if client.server_capabilities.documentHighlightProvider then
		-- 	local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
		-- 	-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		-- 	-- 	buffer = args.buf,
		-- 	-- 	group = highlight_augroup,
		-- 	-- 	callback = function()
		-- 	-- 		vim.lsp.buf.document_highlight()
		-- 	-- 	end,
		-- 	-- })
		--
		-- 	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		-- 		buffer = args.buf,
		-- 		group = highlight_augroup,
		-- 		-- callback = vim.lsp.buf.clear_references,
		--
		-- 		callback = function()
		-- 			vim.lsp.buf.clear_references()
		-- 			vim.lsp.buf.document_highlight()
		-- 		end,
		-- 	})
		--
		-- 	vim.api.nvim_create_autocmd("LspDetach", {
		-- 		group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
		-- 		callback = function(event2)
		-- 			vim.lsp.buf.clear_references()
		-- 			vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
		-- 		end,
		-- 	})
		-- end
	end,
})
