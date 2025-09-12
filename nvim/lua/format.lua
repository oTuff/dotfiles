require("conform").setup({
	formatters_by_ft = {
		nix = { "nixfmt" }, -- default
		python = { "ruff_format" }, -- default
		-- rust = { "rustfmt" }, -- just use rust_analyzer to format
		toml = { "taplo" }, -- default
		elixir = { "mix" }, -- default
		yaml = { "prettier" }, -- yaml lsp have inbuild formatter
		sql = { "sqruff", lsp_format = "never" }, -- has lsp
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		graphql = { "prettier" },
		-- json = { "prettier" },
		-- jsonc = { "prettier" },
		markdown = { "deno_fmt" },
		go = { "goimports", "gofmt" },
		-- gotmpl = { "djlint" },
		-- ["*"] = { "injected" }, -- for markdown code blocks
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
})

require("conform").formatters.injected = { options = { ignore_errors = true } }
