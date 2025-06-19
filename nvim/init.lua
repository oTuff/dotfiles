require("opts")
require("keymap")
require("autocmd")
require("lsp")
require("treesitter")
require("format")
require("git")
require("snippet")
require("indent")
-- require("myai")

-- Other plugins
require("nvim-autopairs").setup({ check_ts = true })
require("mini.icons").setup()
require("mini.files").setup()
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

-- File templates
vim.api.nvim_create_user_command("Templ", function()
	vim.api.nvim_feedkeys(":0read ~/Templates/", "n", false)
end, {})

-- Otter stuff

-- require("otter").setup()
-- require("otter").activate()
-- {
-- 	lsp = {
-- 		["javascript"] = { "ts_ls" },
-- 		["typescript"] = { "ts_ls" },
-- 	},
-- })
-- vim.api.nvim_create_autocmd("InsertEnter", {
-- 	group = vim.api.nvim_create_augroup("otter-autostart", {}),
-- 	-- ...But this only runs in markdown and quarto documents
-- 	pattern = { "*.md", "*.qmd" },
-- 	callback = function()
-- 		-- Get the treesitter parser for the current buffer
-- 		local ok, parser = pcall(vim.treesitter.get_parser)
-- 		if not ok then
-- 			return
-- 		end
--
-- 		local otter = require("otter")
-- 		local extensions = require("otter.tools.extensions")
-- 		local attached = {}
--
-- 		-- Get the language for the current cursor position (this will be
-- 		-- determined by the current code chunk if that's where the cursor
-- 		-- is)
-- 		local line, col = vim.fn.line(".") - 1, vim.fn.col(".")
-- 		local lang = parser:language_for_range({ line, col, line, col + 1 }):lang()
--
-- 		-- If otter has an extension available for that language, and if
-- 		-- the LSP isn't already attached, then activate otter for that
-- 		-- language
-- 		if extensions[lang] and not vim.tbl_contains(attached, lang) then
-- 			table.insert(attached, lang)
-- 			vim.schedule(function()
-- 				otter.activate({ lang }, true, true)
-- 			end)
-- 		end
-- 	end,
-- })

-- Mostly for tailwind:
-- require("nvim-highlight-colors").setup()

-- require("lint").linters_by_ft = {
-- 	lua = { "luacheck" },
-- }

vim.filetype.add({
	pattern = {
		[".?env.?.*"] = "dotenv",
	},
})
