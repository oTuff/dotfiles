vim.opt_local.shiftwidth = 2

vim.snippet.add("clg", "console.log(${1})", { buffer = 0 })

-- mostly for tailwind:
require("nvim-highlight-colors").setup()

-- should also be enabled in html maybe others?
require("nvim-ts-autotag").setup()

-- maybe in react specific filetypes jsx/tsx instead:
require("ts_context_commentstring").setup({ enable_autocmd = false })
local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
	return option == "commentstring" and require("ts_context_commentstring.internal").calculate_commentstring()
		or get_option(filetype, option)
end
