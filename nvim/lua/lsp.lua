local lspconfig = require("lspconfig")
local servers = {
	nixd = { -- using nixfmt seems to be the default
		-- settings = {
		-- 	nixd = {
		-- 		formatting = {
		-- 			command = { "nixfmt" },
		-- 		},
		-- 	},
		-- },
	},
	lua_ls = {
		settings = { Lua = { diagnostics = { globals = { "vim" } } } },
	},
	pylyzer = {},
	-- basedpyright = {
	-- 	settings = {
	-- 		basedpyright = { disableOrganizeImports = true },
	-- 		python = { analysis = { ignore = { "*" } } },
	-- 	},
	-- },
	ruff = {},
	ts_ls = {
		-- root_dir = lspconfig.util.root_pattern("package.json"),
		-- single_file_support = false,
	},
	-- denols = {
	-- 	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
	-- },
	eslint = {},
	jsonls = {},
	html = {},
	cssls = {},
	tailwindcss = {},
	elixirls = {},
	gopls = {
		filetypes = { "go", "gomod", "gowork", "gotmpl", "html" },

		settings = {
			gopls = {
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				templateExtensions = { "html" },
			},
		},
	},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
					-- enable = false,
				},
				-- diagnostics = { enable = false },
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
	-- dockerls = {},
	-- docker_compose_language_service = {},
	-- ansiblels = {},
	bashls = {},
	marksman = {},
	typos_lsp = { init_options = { diagnosticSeverity = "Info" } },
	harper_ls = {
		filetypes = { "tex", "gitcommit" },
	},
}

-- for json, html and css lsps
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

for server_name, server_config in pairs(servers) do
	server_config.capabilities = capabilities

	lspconfig[server_name].setup(server_config)
end

require("blink-cmp").setup({ cmdline = { enabled = false } })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(args)
		if vim.lsp.inlay_hint then
			-- vim.lsp.inlay_hint.enable(true, { 0 })
			vim.keymap.set("n", "<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end)

			-- local client = vim.lsp.get_client_by_id(args.data.client_id)
			-- if client.supports_method("textDocument/completion") then
			-- 	if vim.version().minor == 11 then
			-- 		vim.keymap.set("i", "<C-space>", vim.lsp.completion.trigger)
			--
			-- 		-- Enable Neovim 0.11 native autocomplete
			-- 		-- vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			-- 		vim.lsp.completion.enable(true, client.id, args.buf)
			-- 	end
			--
			-- 	-- Improved autocompletion
			-- 	vim.api.nvim_create_autocmd("InsertCharPre", {
			-- 		pattern = "*",
			-- 		callback = function()
			-- 			vim.schedule(function()
			-- 				local col = vim.fn.col(".") - 1
			-- 				if col > 0 then
			-- 					local prev_char = vim.fn.getline("."):sub(col, col)
			-- 					if
			-- 						vim.fn.pumvisible() == 0
			-- 						and vim.bo.omnifunc ~= ""
			-- 						and (prev_char:match("[%w._]") or prev_char == "-")
			-- 					then
			-- 						if vim.version().minor == 11 then
			-- 							vim.lsp.completion.trigger()
			-- 							-- vim.lsp.buf.signature_help()
			-- 						else
			-- 							vim.api.nvim_feedkeys(
			-- 								vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true),
			-- 								"n",
			-- 								true
			-- 							)
			-- 						end
			-- 					end
			-- 				end
			-- 			end, 300)
			-- 		end,
			-- 	})
			-- end
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if
				client
				and client.supports_method(
					vim.lsp.protocol.Methods.textDocument_documentHighlight,
					{ bufnr = args.buf }
				)
			then
				local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = args.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = args.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end
		end
	end,
})
