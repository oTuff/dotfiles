require("nvim-treesitter.configs").setup({
	indent = { enable = true },
	-- indent = { enable = true, disable = { "yaml" } },
	highlight = {
		enable = true,
		-- disable = { "csv" },
		-- additional_vim_regex_highlighting = true,
	},
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

-- not needed anymore
-- require("ts_context_commentstring").setup({ enable_autocmd = false })
-- local get_option = vim.filetype.get_option
-- vim.filetype.get_option = function(filetype, option)
-- 	return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
-- 		or get_option(filetype, option)
-- end
