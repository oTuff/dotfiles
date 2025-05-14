vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- or just use ctrl+l

-- fzf
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>FzfLua git_status<CR>")
vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>b#<CR>")
-- mostly native fzf alternative commands
-- vim.keymap.set("n", "<leader>ff", ":find <c-z>")
-- vim.keymap.set("n", "<leader>fg", ":grep ")
-- vim.keymap.set("n", "<leader><leader>", ":buffer <c-z>")
-- vim.keymap.set("n", "<leader>gf", "<cmd>GitQuickfix<cr>")

vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>") -- alternatively  use nvim_create_user_command?

local function myFiles()
	require("mini.files").open(vim.api.nvim_buf_get_name(0))
	require("mini.files").reveal_cwd()
end
vim.keymap.set("n", "<leader>e", myFiles)
-- vim.keymap.set("n", "<leader>e", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0)) MiniFiles.reveal_cwd()<CR>")
-- vim.keymap.set("n", "<leader>se", vim.diagnostic.open_float)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
