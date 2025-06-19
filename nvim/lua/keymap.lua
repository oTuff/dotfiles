vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- or just use ctrl+l

-- FZF
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>FzfLua git_status<CR>")
vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<CR>")

-- mostly native fzf alternative commands
-- vim.keymap.set("n", "<leader>ff", ":find <c-z>")
-- vim.keymap.set("n", "<leader>fg", ":grep ")
-- vim.keymap.set("n", "<leader>gf", "<cmd>GitQuickfix<cr>")
-- vim.keymap.set("n", "<leader><leader>", ":buffer <c-z>")

vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>") -- alternatively  use nvim_create_user_command?

local function myFiles()
	local minifiles = require("mini.files")
	minifiles.open(vim.api.nvim_buf_get_name(0))
	minifiles.reveal_cwd()
end

vim.keymap.set("n", "<leader>e", myFiles)
vim.keymap.set("n", "gK", vim.diagnostic.open_float)
