require("nvim-treesitter.configs").setup({
	indent = { enable = true },
	highlight = { enable = true },
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

require("treesitter-context").setup({
	max_lines = 3,
	multiline_threshold = 1,
	trim_scope = "inner",
})

require("nvim-ts-autotag").setup()

-- Inject gotmpl treesitter in html
vim.treesitter.query.set(
	"html",
	"injections",
	[[
  ((text) @injection.content
   (#set! injection.language "gotmpl"))
]]
)
