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

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false

vim.opt.diffopt:append("vertical,linematch:60")

-- Diagnostics
vim.diagnostic.config({ virtual_text = { current_line = true } })
-- vim.diagnostic.config({ virtual_text = true })
-- vim.diagnostic.config({ virtual_lines = { current_line = true } })

vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "NvimLightGrey4" })
