require("lspconfig")
vim.lsp.enable({
	"bashls",
	"clangd",
	"cssls",
	"denols",
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
	"pyright",
	"ruff",
	"rust_analyzer",
	"sqls",
	"sqruff",
	"tailwindcss",
	"taplo",
	"ts_ls",
	"ty",
	"typos_lsp",
	"yamlls",
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

		-- Inlay Hints
		if client.server_capabilities.inlayHintProvider then
			vim.keymap.set("n", "<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end)
		end

		-- Highlight current item
		if client.server_capabilities.documentHighlightProvider then
			vim.keymap.set("n", "g*", vim.lsp.buf.document_highlight)
			vim.keymap.set("n", "<Esc>", function()
				vim.cmd("nohlsearch")
				vim.lsp.buf.clear_references()
			end)
		end
	end,
})
