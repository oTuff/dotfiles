require("nvim-treesitter.configs").setup({
	indent = { enable = true },
	highlight = {
		enable = true,
		disable = { "csv" },
		additional_vim_regex_highlighting = false,
	},
	-- incremental_selection = {
	-- 	enable = true,
	-- },
	-- refactor = {
	-- highlight_current_scope = { enable = true },
	-- highlight_definitions = {
	-- 	enable = true,
	-- 	clear_on_cursor_move = false,
	-- },

	-- treesitter context aware navigation
	-- navigation = {
	-- 	enable = true,
	-- 	keymaps = {
	-- 		goto_definition = "gd",
	-- 		list_definitions = "gnD",
	-- 		list_definitions_toc = "gO",
	-- 		goto_next_usage = "*",
	-- 		goto_previous_usage = "#",
	-- 	},
	-- },

	-- kind of useless when you have lsp rename
	-- smart_rename = {
	-- 	enable = true,
	-- 	-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
	-- 	keymaps = {
	-- 		smart_rename = "grr",
	-- 	},
	-- },
	-- },
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["as"] = "@local.scope",
			},
		},
	},
})

require("treesitter-context").setup({
	max_lines = 3,
	multiline_threshold = 1,
	trim_scope = "inner",
})
