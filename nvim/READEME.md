# Neovim getting started guide

Running `:tutor` to get a tutorial

Neovim is configured with lua if you don't know anything about Lua, I recommend
taking some time to read through a guide. One possible example which will only
take 10-15 minutes: - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

`:help`. This will open up a help window with some basic information about
reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

I have left several `:help X` comments throughout the init.lua These are hints
about where to find more information about the relevant settings, plugins or
Neovim features used in Kickstart.

---

A nice place to start is https://github.com/nvim-lua/kickstart.nvim (a lot of
this guide is taken directly from there) and the accompanying video:
https://www.youtube.com/watch?v=m8C0Cq9Uv9o (by TJ DeVries who also have a lot
of other great educational content)

## Keymaps

```
<c-n> is Control + n
```

Neovim has some nice default keymaps for things like lsp features.

```
K - (shift k) information about item under the cursor
gra - code action
grr - show references
grn - rename item under the cursor
<c-]> - go to definition

]d next diagnostic 
[d previous diagnostic

in completion menu:
<c-n> - next
<c-p> - previous
<c-y> - accept completion
<c-s> - signature help
```

custom keymaps

the leaderkey can be used with custom commands. many set this as space.

```lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- remove highligth when pressing escape
```

## Options

You probably want linenumbers. Relative linenumbers can also help in neovim.

```lua
vim.opt.number = true
vim.opt.relativenumber = true
```

File indentation. Neovim has some defaults for different languages which can be
overwritten globally with the following settings. Filetype specific overwrites
can be done with `ftplugin`(see the next section)

```lua
vim.opt.tabstop = 4 -- how big tabs should be
-- vim.opt.softtabstop = 0 -- How many spaces inserted/deleted w/ <Tab> or <Backspace>
-- (default = 0 which means fallsback to shiftwidth)

vim.opt.shiftwidth = 0 -- how many spaces for indentation (when using `noexpandtab`).
-- By using 0 it will be the same as tabstop

vim.opt.expandtab = false -- tabs will be replaced with spaces (personal preference)
```

Clipboard: by default neovim has different "registers" for copied/deleted text.
For example by typing `"+` before `y` or `p` can be used to access the system
clipboard. Alternatively you can sync the clipboard with the below snippet.

```lua
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
```

Improved searching:

```lua
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
```

You can add visual column for specific character lengths

```lua
vim.opt.colorcolumn = "80"
```

This can be nice for gitcommit to keep your messages an appropriate length:

~/.config/neovim/after/ftplugin/gitcommit.lua

```lua
vim.opt_local.colorcolumn = "50,72"
```

Nice highlight of current line (looks good with default colorscheme)

```lua
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
```

Spellcheking: (`:h spell`). use `]s` and `[s` to jump between misspelled words.
`z=` will show suggestions

```lua
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spellsuggest = "best,5"
```

For autocompletion these settings are nice.(also look at the LSP section for
code completion)

Commands for completion

```
<c-x></c-n> (words from the current buffer)
<c-x></c-f> (filepaths from the current working directory)
```

```lua
vim.opt.completeopt = "menuone,noinsert,fuzzy"
vim.opt.pumheight = 10
```

You can also change the behavior of completion for commands like:

```lua
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignorecase = true
```

Neovim can be used as gitdiff tool to show diffs from git. this setting can help
it look better - maybe search on the internet for other solutions?(look at git
integration section)

```lua
vim.opt.diffopt:append("vertical,linematch:60")
```

Folding is integrated and can be used with Treesitter(which can be nice for
large markdown files for example) - treesitter need to be setup(see Treesitter
section)

```lua
-- Folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false -- disable folding by default
```

I personally like the commented out lines to be italic like so:

```lua
-- make comments italic while keeping the color the same as default
vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "NvimLightGrey4" })
```

Default is to split above and left. Can be changed with

```lua
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
```

Other nice settings you can try

```lua
vim.opt.wrap = false -- text don't wrap
vim.opt.scrolloff = 10 -- always show 10 lines above/below
vim.opt.undofile = true -- Save undo history
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.breakindent = true -- Enable break indent
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true
```

## Ftplugin

In ~/.config/neovim/after/ftplugin/\<filetype\>.lua can set language specific
settings like so:

~/.config/neovim/after/ftplugin/javascript.lua

```lua
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true
```

And other languages can use the same settings by
~/.config/neovim/after/ftplugin/typescript.lua

```lua
vim.cmd.runtime("ftplugin/javascript.lua")
```

## Autocommands

Autocommand are code that are executed based on different conditions(explained
really well by TJ in the video linked at the top of this file)

```lua
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
```

## Language Server Protocol (lsp)

lsp is how neovim gets language specific features like autocomplete and
formatting. https://github.com/neovim/nvim-lspconfig has a repo of default
configurations for different language servers. It is nice to get up and started
quickly although it is not necessary. The configs that nvim-lspconfig provides
often has information on how to enable more settings(like the lua_ls example
below). But the lsp must be installed. You can manually install it through you
systems package manager or for example nix. Many neovim users like to use mason
for this as well: https://github.com/williamboman/mason.nvim

Below is a rather large snippet to configure lsp with completion and some other
settings. Since neovim 0.11 it has build in autocompletion which can be
configured by the below. Alternatively plugins can be used like

https://github.com/Saghen/blink.cmp,
https://github.com/echasnovski/mini.completion or the older
https://github.com/hrsh7th/nvim-cmp

```lua
local lspconfig = require("lspconfig")
local servers = {
	nixd = {}, -- use the defaults provided by lspconfig
	lua_ls = { -- nice config of lua for use with neovim(from lspconfig repo)
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
		single_file_support = false,
		settings = {
			gopls = {
				templateExtensions = { "gohtml" },
			},
		},
	},
}

-- setup all the servers from the list above
for server_name, server_config in pairs(servers) do
	lspconfig[server_name].setup(server_config)
end

-- setup lsp specific actions like completions etc.
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

		-- Inlay hints
		if client.server_capabilities.inlayHintProvider then
			vim.keymap.set("n", "<leader>ih", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
			end)
		end

		-- -- For now I use Conform instead
		-- -- Autoformatting
		-- if client.server_capabilities.documentFormattingProvider then
		-- 	vim.api.nvim_create_autocmd('BufWritePre', {
		-- 		buffer = args.buf,
		-- 		callback = function()
		-- 			vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
		-- 		end,
		-- 	})
		-- end

		-- Auto highlight current item(similar to vscode)
		-- if
		-- 	client
		-- 	and client.supports_method(
		-- 		vim.lsp.protocol.Methods.textDocument_documentHighlight,
		-- 		{ bufnr = args.buf }
		-- 	)
		-- then
		-- 	local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
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
		-- 		group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
		-- 		callback = function(event2)
		-- 			vim.lsp.buf.clear_references()
		-- 			vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
		-- 		end,
		-- 	})
		-- end
	end,
})
```

## nice stuff you might be used to:

**Indentation**

You can set listchars for specific situations. the extends and precedes are
particularly nice when having wrap set to false

These can also be used for a very simple indentation guides that follow the
current tab/shiftwidth settings:

```lua
vim.opt.list = true
vim.opt.listchars = {
	-- tab = "▏ ", -- set for global default value
	-- leadmultispace = "▏ ", -- set for global default value
	trail = "·",
	extends = "»",
	precedes = "«",
}

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("indent-char", { clear = true }),
	pattern = "*",
	callback = function()
		if vim.bo.expandtab == true then
			vim.opt_local.listchars:append({
				leadmultispace = "▏" .. string.rep(" ", vim.bo.shiftwidth - 1),
			})
		else
			vim.opt_local.listchars:append({ tab = "▏ " })
		end
	end,
})
```

**close pairs** auto close brackets etc.

https://github.com/windwp/nvim-autopairs

```lua
require("nvim-autopairs").setup({ check_ts = true })
```

## Treesitter

Neovim uses treesitter for syntax highlight and for a better understanding of
the code syntax. like indentation. it can also help with incremental selection
and to show code context(like you might be used to from vscode). it can also
help with autocompleting brackets etc. treesitter can install the needed gramar
files for you with commands or automatically(look at the nvim-treesitter repo).
Nix can also be used to manage treesitter grammars.

https://github.com/nvim-treesitter/nvim-treesitter

https://github.com/nvim-treesitter/nvim-treesitter-context

https://github.com/windwp/nvim-ts-autotag

```lua
require("nvim-treesitter.configs").setup({
	indent = { enable = true },
	-- indent = { enable = true, disable = { "yaml" } },
	highlight = {
		enable = true,
		-- disable = { "csv" },
		-- additional_vim_regex_highlighting = true,
	},
	-- incremental selection. Not necessary
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
})

-- context show the current scope of function etc.
require("treesitter-context").setup({
	max_lines = 3,
	multiline_threshold = 1,
	trim_scope = "inner",
})

-- autotags. nice for html
require("nvim-ts-autotag").setup()
```

## plugins

Plugins are basically just lua code that neovim can load to extend it. you can
manually install plugins by placing them in the correct folder

~/.config/nvim/pack/nvim/start/

~/.local/share/nvim/site/pack/*/start

but it is much easier to use a plugin manager to install and manage plugins
like:

https://github.com/folke/lazy.nvim

or

https://github.com/savq/paq-nvim

nix can also be used with home-manager to manage plugins(like in my dotfiles) -
look at home.nix under programs.neovim = {

https://github.com/otuff/dotfiles

Besides nvim-lspconfig and nvim-treesitter other "must have" plugins are:

**Fuzzy search** (like the ctrl-p from vscode):

https://github.com/nvim-telescope/telescope.nvim

https://github.com/ibhagwan/fzf-lua

```
-- fzf
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>FzfLua git_status<CR>")
vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<CR>")
```

**File explorer** altough the default netrw can be used(with commands like :E or
:Le) - but it kinda sucks

https://github.com/nvim-tree/nvim-tree.lua

https://github.com/nvim-neo-tree/neo-tree.nvim

https://github.com/echasnovski/mini.files

```lua
require("mini.icons").setup()
require("mini.files").setup()

vim.keymap.set("n", "<leader>e", 
  "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0)) MiniFiles.reveal_cwd()<CR>")
```

**formatting** you can use a autocommand to use the lsp for formatting but for
more granular control conform is nice:

https://github.com/stevearc/conform.nvim

```lua
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
```

**linting** similar to formatting external linters can be used

https://github.com/mfussenegger/nvim-lint

```lua
require("lint").linters_by_ft = {
	lua = { "luacheck" },
}
```

**Snippets**

Maybe kinda hacky snippet integration. alternatively luasnip can be used:

https://github.com/L3MON4D3/LuaSnip

```lua
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
```

~/.config/neovim/after/ftplugin/go.lua

```lua
vim.snippet.add("ie", "if err != nil{\n${1}\n}", { buffer = 0 })
```

## Git integration

Git can use neovim as the default editor and diff and merge tool:
https://gist.github.com/karenyyng/f19ff75c60f18b4b8149

to get gitsigns in the sign collumn(like vscode)

https://github.com/lewis6991/gitsigns.nvim

```lua
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
```

## My most used neovim key combinations / commands

```
J - move the below line up at the end of the current
Y - yank to the end of line
D - delete to the end of line
$ - end of line
0 - start of line
^ - start of text on line
ci" - change inside quotes(can be used with many combinations yi" or ya" - a for
around)
V$% - select a codeblock (around {}) for example
V I - visual line mode, select some code and write something in front(for all lines)
can be used for comments for example. although the next combination is nicer

gcc - comment the selected line the second "c" cand also be a motion ( gc2k) to 
comment the current line and the two above

cgn - change the current searched word(with "/") then you can use "n" to go to 
the next word and press "." to also change that. although the next command migth be more usefull

:%S/word/newword/gc - search and replace "word" with "newword". the "g" means 
globally(replace all the words on the same line). "c" is to confirm each(neovim 
will go through and ask - "y" or "n")

f and F - until forward or backwards. nice to select text.
t and T - similar to "f" but goes to the char before.
```

Neovim is supper awesome and can be configured to your liking. If you are in
doubt the documentation is super nice. Use `:h` and read the documentation for
github repos README.

You should definitely take a look at some of the awesome neovim plugins and look
at what other plugins the authors have made and search around the web for more
awesome neovim stuff.
