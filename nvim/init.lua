require("opts")
require("keymap")
require("autocmd")
require("lsp")
require("treesitter")
require("format")
require("git")
require("snippet")
require("indent")
require("myai")

-- Diagnotics
-- vim.diagnostic.config({ virtual_text = true })
-- vim.diagnostic.config({ virtual_lines = { current_line = true } })
-- vim.keymap.set("n", "gK", function()
-- 	local new_config = not vim.diagnostic.config().virtual_lines
-- 	vim.diagnostic.config({ virtual_lines = new_config })
-- end, { desc = "Toggle diagnostic virtual_lines" })
vim.keymap.set("n", "gK", vim.diagnostic.open_float)

-- require("fidget").setup()
-- require("oil").setup({ view_options = { show_hidden = true } })
-- require("nvim-tree").setup({
-- 	update_focused_file = { enable = true },
-- 	view = { adaptive_size = true },
-- 	git = { ignore = false },
-- })

-- Grep and Find
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
-- vim.keymap.set("n", "<leader>ff", ":find ")

-- Other plugins
require("nvim-autopairs").setup({ check_ts = true })
require("mini.icons").setup()
require("mini.files").setup()

-- Mostly for tailwind:
-- require("nvim-highlight-colors").setup()

-- require("lint").linters_by_ft = {
-- 	lua = { "luacheck" },
-- }
