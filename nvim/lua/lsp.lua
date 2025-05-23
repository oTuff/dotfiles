local lspconfig = require("lspconfig")
local servers = {
	nixd = {},
	lua_ls = {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						"${3rd}/luv/library",
					},
				},
			})
		end,
		settings = {
			Lua = {},
		},
	},
	gopls = {
		filetypes = { "go", "gomod", "gowork", "gotmpl", "html" },
		single_file_support = false, -- only run for html files in a go project
		settings = {
			gopls = {
				templateExtensions = { "gohtml" },
				-- hints = {
				-- 	assignVariableTypes = true,
				-- 	compositeLiteralFields = true,
				-- 	compositeLiteralTypes = true,
				-- 	constantValues = true,
				-- 	functionTypeParameters = true,
				-- 	parameterNames = true,
				-- 	rangeVariableTypes = true,
				-- },
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
	pyright = {
		settings = {
			pyright = {
				disableOrganizeImports = true,
				-- typeCheckingMode = "standard",
			},
			python = { analysis = { ignore = { "*" } } },
		},
	},
	ruff = {},
	-- ts_ls = {
	-- 	-- init_options = {
	-- 	-- 	hostInfo = "neovim",
	-- 	-- 	-- Enable support for JavaScript language injections
	-- 	-- 	plugins = {
	-- 	-- 		{
	-- 	-- 			name = "typescript-lit-html",
	-- 	-- 			location = "npm:typescript-lit-html-plugin",
	-- 	-- 			-- Or locally installed:
	-- 	-- 			-- location = "/path/to/typescript-lit-html-plugin",
	-- 	-- 		},
	-- 	-- 	},
	-- 	-- },
	-- 	root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json"),
	-- 	single_file_support = false,
	-- 	filetypes = {
	-- 		"javascript",
	-- 		"javascriptreact",
	-- 		"javascript.jsx",
	-- 		"typescript",
	-- 		"typescriptreact",
	-- 		"typescript.tsx",
	-- 		"html", -- also enable for html
	-- 	},
	-- },
	denols = {},
	-- 	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
	-- },
	-- eslint = {},
	jsonls = {},
	cssls = {},
	html = {},
	emmet_language_server = {},
	-- tailwindcss = {},
	-- elixirls = {},
	-- sqls = {
	-- 	settings = {
	-- 		sqls = {
	-- 			connections = {
	-- 				{
	-- 					driver = "postgresql",
	-- 					dataSourceName = os.getenv("DBSTRING"),
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
	-- sqlls = {
	-- 	-- filetypes = { "sql" },
	-- 	root_dir = function(_)
	-- 		return vim.loop.cwd()
	-- 	end,
	-- },
	-- postgres_lsp = {},
	yamlls = {
		-- cmd = { "yaml-language-server", "--stdio" },
		-- filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
		-- root_dir = function(fname)
		-- 	return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
		-- end,
		-- single_file_support = true,
		-- settings = {
		-- 	redhat = { telemetry = { enabled = false } },
		-- 	yaml = {
		-- 		format = { enable = { true } }, -- formatting is not default
		-- 	},
		-- },
	},
	taplo = {},
	-- dockerls = {},
	-- docker_compose_language_service = {},
	-- ansiblels = {},
	bashls = {},
	-- Writing
	marksman = {},
	texlab = {
		-- settings = {
		-- 	texlab = {
		-- 		build = { onSave = true },
		-- 	},
		-- },
	},
	-- Spell checking
	typos_lsp = { init_options = { diagnosticSeverity = "Info" } },
	harper_ls = { filetypes = { "gitcommit", "markdown" } },
	ltex_plus = {
		filetypes = { "bib", "tex" }, -- harper don't work on these file types
		-- settings = { ltex = { language = "da-DK" } },
	},
}

for server_name, server_config in pairs(servers) do
	lspconfig[server_name].setup(server_config)
end

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

		-- Autoformatting ( for now I use Conform instead)
		-- if client.server_capabilities.documentFormattingProvider then
		-- 	vim.api.nvim_create_autocmd("BufWritePre", {
		-- 		pattern = "*",
		-- 		callback = function()
		-- 			vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
		-- 		end,
		-- 	})
		-- end

		if client.server_capabilities.documentHighlightProvider then
			vim.keymap.set("n", "g*", vim.lsp.buf.document_highlight)
			vim.keymap.set("n", "<Esc>", function()
				vim.cmd("nohlsearch")
				vim.lsp.buf.clear_references()
			end)

			-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			-- 	group = vim.api.nvim_create_augroup("lsp_highlight", { clear = true }),
			-- 	buffer = args.buf,
			-- 	callback = vim.lsp.buf.clear_references,
			-- })
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
