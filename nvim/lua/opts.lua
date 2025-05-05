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
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spellsuggest = "best,5"
vim.opt.completeopt = "menuone,noinsert,fuzzy"
vim.opt.pumheight = 10
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignorecase = true
vim.opt.diffopt:append("vertical,linematch:60")
-- vim.opt.complete:append("U,f") -- maybe not needed? Others: u, k, kspell, s, i, d, see `h: 'complete'`
-- vim.opt.splitright = true
-- vim.opt.splitbelow = true
-- vim.opt.inccommand = "split"
-- vim.opt.textwidth = 80

vim.opt.breakindent = true

-- make comments italic while keeping the color the same as default
vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "NvimLightGrey4" })

-- Folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false -- disable folding by default
