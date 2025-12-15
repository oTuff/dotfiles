-- TODO: can probably remove conform and just use lsp formatting
-- Only prettier cannot be run through an lsp -> use deno_fmt instead
-- the eslint lsp can run prettier: ez life
require("conform").setup({
	formatters_by_ft = {
		-- nix = { "nixfmt" }, -- default
		-- python = { "ruff_format" }, -- just use ruff lsp
		-- rust = { "rustfmt" }, -- just use rust_analyzer to format
		-- toml = { "taplo" }, -- default
		-- elixir = { "mix" }, -- default
		-- sql = { "sqruff", lsp_format = "never" }, -- has an lsp
		-- lua = { "stylua" }, -- can also run stylua as an lsp
		-- yaml = { "prettier" }, -- yaml lsp have inbuild formatter
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		graphql = { "prettier" },
		-- json = { "prettier" },
		-- jsonc = { "prettier" },
		markdown = { "deno_fmt" }, -- has an lsp
		-- go = { "goimports", "gofmt" },
		-- gotmpl = { "djlint" },
		-- ["*"] = { "injected" }, -- for markdown code blocks
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
})

require("conform").formatters.injected = { options = { ignore_errors = true } }
