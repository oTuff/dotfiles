require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettier" }, -- default
		typescript = { "prettier" }, -- default
		javascriptreact = { "prettier" }, -- default
		typescriptreact = { "prettier" }, -- default
		nix = { "nixfmt" }, -- default
		python = { "ruff_format" }, -- default
		rust = { "rustfmt" }, -- default
		toml = { "taplo" }, -- default
		lua = { "stylua" },
		css = { "prettier" },
		html = { "prettier" },
		-- svelte = { "prettier" },
		graphql = { "prettier" },
		json = { "prettier" }, -- json lsp will respect the editors tabstop setting
		yaml = { "prettier" }, -- yaml lsp have inbuild formatter
		markdown = { "deno_fmt" },
		sql = { "sqlfluff", lsp_format = "never" },
		go = { "goimports", "gofmt" },
		gotmpl = { "djlint" },
		-- ["*"] = { "injected" }, -- for markdown code blocks
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
require("conform").formatters.injected = { options = { ignore_errors = true } }
