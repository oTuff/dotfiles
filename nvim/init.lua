require("opts")
require("keymap")
require("lsp")
require("git")
require("indent")

-- Treesitter
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

-- Other plugins
-- require("nvim-autopairs").setup({ check_ts = true })
require("mini.files").setup({
	content = { prefix = function() end }, -- disable icons
	mappings = {
		close = "<esc>",
		-- go_in = "<enter>",
		-- go_out = "-",
	},
})
require("telescope").setup({ defaults = require("telescope.themes").get_ivy() })

-- Auto Command
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Grep and Find
--
-- vim.opt.grepprg = "rg --vimgrep --smart-case"
-- vim.keymap.set("n", "<leader>fg", function()
-- 	local pattern = vim.fn.input("grep: ")
-- 	if pattern ~= "" then
-- 		vim.cmd('silent grep! "' .. pattern .. '"')
-- 		vim.cmd("copen")
-- 	end
-- end)

function Fd(file_pattern, _)
	if file_pattern:sub(1, 1) == "*" then -- if first char is * then fuzzy search
		file_pattern = file_pattern:gsub(".", ".*%0") .. ".*"
	end
	local cmd = 'fd  --color=never --full-path --type file --hidden --exclude=".git" "' .. file_pattern .. '"'
	local result = vim.fn.systemlist(cmd)
	return result
end
vim.opt.findfunc = "v:lua.Fd"
