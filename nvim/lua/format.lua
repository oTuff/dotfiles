require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "deno_fmt" }, -- default
		typescript = { "deno_fmt" }, -- default
		javascriptreact = { "deno_fmt" }, -- default
		typescriptreact = { "deno_fmt" }, -- default
		css = { "deno_fmt" },
		html = { "deno_fmt" },
		-- svelte = { "deno_fmt" },
		-- graphql = { "deno_fmt" },
		json = { "deno_fmt" }, -- json lsp will respect the editors tabstop setting
		yaml = { "deno_fmt" }, -- yaml lsp have inbuild formatter
		markdown = { "deno_fmt" },
		-- sql = { "pg_format", lsp_format = "never" },
		go = { "goimports", "gofmt" },
		-- Below mostly for markdown code block formatting(since they work through the LSP anyways)
		nix = { "nixfmt" },
		python = { "ruff_format" },
		rust = { "rustfmt" },
		toml = { "taplo" },
		["*"] = { "injected" }, -- for markdown code blocks
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
require("conform").formatters.injected = { options = { ignore_errors = true } }
