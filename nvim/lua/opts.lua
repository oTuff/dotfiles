vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.updatetime = 250
-- vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
-- vim.opt.spell = true -- use `typos`, `harper`, and `ltex_plus` instead
-- vim.opt.spelloptions = "camel"
vim.opt.spellsuggest = "best,10"
--
-- vim.opt.completeopt = "menuone,noinsert,fuzzy"
vim.opt.completeopt = "menuone,noinsert"
vim.opt.pumheight = 10
vim.opt.wildmode = "longest:full,full"
vim.opt.wildoptions = "pum,tagfile,fuzzy"
vim.opt.wildignorecase = true

-- vim.o.foldcolumn = "1"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false

vim.opt.diffopt:append("vertical,linematch:60")

-- TODO: will maybe not expand the signcolumn if a line has an error but no git change
-- since it will be on column 1 like the gitsigns?
-- vim.opt.signcolumn = "auto:1-3" -- expand when showing errors and warnings
-- vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%l%s"
vim.opt.signcolumn = "auto:1-2" -- TODO: why are warnings shown over errors???
vim.diagnostic.config({
	virtual_text = { current_line = true },
	signs = {
		-- TODO: Hint color is overwriting Error on the same line???
		-- Simple fix: Just have the text be 2 characters?
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticError",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
		},
		text = {
			[vim.diagnostic.severity.ERROR] = "E",
			[vim.diagnostic.severity.WARN] = "W",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

-- vim.api.nvim_set_hl(0, "Comment", { italic = true })
vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "NvimLightGrey4" })
