vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.list = true
vim.opt.listchars = {
	tab = "▏ ",
	leadmultispace = "▏ ", -- default when expandtab is enabled (2 spaces)
	trail = "·",
	extends = "»",
	precedes = "«",
}
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spellsuggest = "best,5"
vim.opt.completeopt = "menuone,noinsert" -- for autocompletion
vim.opt.splitright = true
vim.opt.diffopt:append("vertical,linematch:60")
-- vim.opt.shortmess = "OlToFcCT" -- not needed for 0.11 completion
-- vim.opt.complete:append("f")
-- vim.opt.wildmode = "longest:full,full"
-- vim.opt.wildignorecase = true
-- vim.opt.pumheight = 10
-- vim.opt.splitbelow = true
-- vim.opt.inccommand = "split"
-- vim.opt.textwidth = 80

-- make comments italic while keeping the color the same as default
vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "NvimLightGrey4" })
