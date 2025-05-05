require("opts")
require("keymap")
require("autocmd")
require("lsp")
require("treesitter")
require("myai")
require("indent")
-- require("pandoc")

require("nvim-autopairs").setup({ check_ts = true })
-- require("fidget").setup()
-- require("oil").setup({ view_options = { show_hidden = true } })
-- require("nvim-tree").setup({
-- 	update_focused_file = { enable = true },
-- 	view = { adaptive_size = true },
-- 	git = { ignore = false },
-- })

-- vim.opt.grepprg = "rg --vimgrep --smart-case"
-- vim.keymap.set("n", "<leader>fg", function()
-- 	local pattern = vim.fn.input("grep: ")
-- 	if pattern ~= "" then
-- 		vim.cmd('silent grep! "' .. pattern .. '"')
-- 		vim.cmd("copen")
-- 	end
-- end)

function Fd(file_pattern, _)
	if file_pattern:sub(1, 1) == "*" then -- if first char is * then fuzzy search
		file_pattern = file_pattern:gsub(".", ".*%0") .. ".*"
	end
	local cmd = 'fd  --color=never --full-path --type file --hidden --exclude=".git" "' .. file_pattern .. '"'
	local result = vim.fn.systemlist(cmd)
	return result
end
vim.opt.findfunc = "v:lua.Fd"
-- vim.keymap.set("n", "<leader>ff", ":find ")

require("mini.icons").setup()
require("mini.files").setup()

-- Mostly for tailwind:
require("nvim-highlight-colors").setup()

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "deno_fmt" },
		typescript = { "deno_fmt" },
		javascriptreact = { "deno_fmt" },
		typescriptreact = { "deno_fmt" },
		css = { "deno_fmt" },
		html = { "deno_fmt" },
		svelte = { "deno_fmt" },
		graphql = { "deno_fmt" },
		json = { "deno_fmt" }, -- json lsp will respect the editors tabstop setting
		yaml = { "deno_fmt" }, -- yaml lsp have inbuild formatter
		markdown = { "deno_fmt" },
		sql = { "pg_format", lsp_format = "never" },
		go = { "goimports", "gofmt" },
		-- Below mostly for markdown code block formatting(since they work through the lsp's anyways)
		rust = { "rustfmt" },
		nix = { "nixfmt" },
		toml = { "taplo" },
		python = { "ruff_format" },
		["*"] = { "injected" }, -- for markdown code blocks
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
require("conform").formatters.injected = { options = { ignore_errors = true } }

require("lint").linters_by_ft = {
	lua = { "luacheck" },
}

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end)
	end,
})

-- Native snippet support
function vim.snippet.add(trigger, body, opts)
	vim.keymap.set("ia", trigger, function()
		-- If abbrev is expanded with keys like "(", ")", "<cr>", "<space>",
		-- don't expand the snippet. Only accept "<c-]>" as trigger key.
		local c = vim.fn.nr2char(vim.fn.getchar(0))
		if c ~= "" then
			vim.api.nvim_feedkeys(trigger .. c, "i", true)
			return
		end
		vim.snippet.expand(body)
	end, opts)
end
