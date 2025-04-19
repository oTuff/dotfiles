local lspconfig = require("lspconfig")
local servers = {
	nixd = {},
	lua_ls = {
		settings = { Lua = { diagnostics = { globals = { "vim" } } } },
	},
	basedpyright = {
		settings = {
			basedpyright = { disableOrganizeImports = true },
			python = { analysis = { ignore = { "*" } } },
		},
	},
	ruff = {},
	ts_ls = {
		-- root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
		-- single_file_support = false,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"html",
		},
	},
	denols = {
		root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
		-- filetypes = {
		-- 	"javascript",
		-- 	"javascriptreact",
		-- 	"javascript.jsx",
		-- 	"typescript",
		-- 	"typescriptreact",
		-- 	"html",
		-- 	"typescript.tsx",
		-- },
	},
	eslint = {},
	jsonls = {},
	cssls = {},
	html = {},
	-- emmet_language_server = {},
	tailwindcss = {},
	elixirls = {},
	gopls = {
		filetypes = { "go", "gomod", "gowork", "gotmpl", "html" },
		single_file_support = false,
		settings = {
			gopls = {
				templateExtensions = { "gohtml" },
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
	},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
	-- bacon_ls = {
	-- 	init_options = {
	-- 		updateOnSave = true,
	-- 		updateOnSaveWaitMillis = 1000,
	-- 		updateOnChange = false,
	-- 	},
	-- },
	sqls = {
		settings = {
			sqls = {
				connections = {
					{
						driver = "postgresql",
						dataSourceName = os.getenv("DBSTRING"),
					},
				},
			},
		},
	},
	-- sqlls = {
	-- 	-- filetypes = { "sql" },
	-- 	root_dir = function(_)
	-- 		return vim.loop.cwd()
	-- 	end,
	-- },
	-- postgres_lsp = {},
	yamlls = {
		cmd = { "yaml-language-server", "--stdio" },
		filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
		root_dir = function(fname)
			return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
		end,
		single_file_support = true,
		settings = {
			redhat = { telemetry = { enabled = false } },
			yaml = {
				format = { enable = { true } }, -- formatting is not default
			},
		},
	},
	taplo = {},
	-- dockerls = {},
	-- docker_compose_language_service = {},
	-- ansiblels = {},
	bashls = {},
	marksman = {},
	-- typos_lsp = { init_options = { diagnosticSeverity = "Info" } },
	harper_ls = { -- doesn't even work with latex disappointing
		filetypes = { "gitcommit" },
	},
	-- ltex = {},
	texlab = {
		-- settings = {
		-- 	texlab = {
		-- 		build = { onSave = true },
		-- 	},
		-- },
	},
}

for server_name, server_config in pairs(servers) do
	lspconfig[server_name].setup(server_config)
end

-- emmet_language_server must start after html and gopls to avoid issues
vim.defer_fn(function()
	lspconfig.emmet_language_server.setup({})
	-- vim.cmd("silent! e!")
	vim.cmd("e!")
end, 500)

-- neovim 0.11
-- for server_name, server_config in pairs(servers) do
-- 	vim.lsp.config(server_name, server_config)
-- 	vim.lsp.enable(server_name)
-- end

-- Special handling for emmet_language_server
-- vim.defer_fn(function()
-- 	vim.lsp.enable("emmet_language_server")
-- 	vim.cmd("e")
-- end, 2000)

-- vim.defer_fn(function()
-- 	vim.lsp.enable("emmet_language_server")
-- 	vim.lsp.config("emmet_language_server", {})
-- end, 2000)

-- require("blink-cmp").setup({ cmdline = { enabled = false } })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client.supports_method("textDocument/completion") then
			vim.keymap.set("i", "<C-space>", vim.lsp.completion.get)
			client.server_capabilities.completionProvider.triggerCharacters =
				vim.split(".!>abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRTUVWXYZ", "", true)
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		if client.server_capabilities.inlayHintProvider then
			-- vim.lsp.inlay_hint.enable(true, { 0 })
			vim.keymap.set("n", "<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end)
		end

		-- Autoformatting
		-- 			if client:supports_method('textDocument/formatting') then
		-- 	vim.api.nvim_create_autocmd('BufWritePre', {
		-- 		buffer = args.buf,
		-- 		callback = function()
		-- 			vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
		-- 		end,
		-- 	})
		-- end

		-- auto highlight current item
		-- if
		-- 	client
		-- 	and client.supports_method(
		-- 		vim.lsp.protocol.Methods.textDocument_documentHighlight,
		-- 		{ bufnr = args.buf }
		-- 	)
		-- then
		-- 	local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
		-- 	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		-- 		buffer = args.buf,
		-- 		group = highlight_augroup,
		-- 		callback = vim.lsp.buf.document_highlight,
		-- 	})
		--
		-- 	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		-- 		buffer = args.buf,
		-- 		group = highlight_augroup,
		-- 		callback = vim.lsp.buf.clear_references,
		-- 	})
		--
		-- 	vim.api.nvim_create_autocmd("LspDetach", {
		-- 		group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
		-- 		callback = function(event2)
		-- 			vim.lsp.buf.clear_references()
		-- 			vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
		-- 		end,
		-- 	})
		-- end
	end,
})
