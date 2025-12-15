require("nvim-treesitter.configs").setup({
	indent = { enable = true },
	highlight = { enable = true },
})

require("treesitter-context").setup({
	max_lines = 3,
	multiline_threshold = 1,
	trim_scope = "inner",
})

require("nvim-ts-autotag").setup()

-- vim.filetype.add({
-- 	extension = {
-- 		tmpl = "gotmpl",
-- 	},
-- })
