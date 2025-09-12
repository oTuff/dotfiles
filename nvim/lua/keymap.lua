vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- or just use ctrl+l

-- FZF
-- vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>")
-- vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>")
-- vim.keymap.set("n", "<leader>gf", "<cmd>FzfLua git_status<CR>")
-- vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<CR>")
-- vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua marks<CR>")

-- Telescope
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>Telescope git_status<CR>")
-- vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader><leader>", function()
	require("telescope.builtin").buffers({ sort_lastused = true })
end)
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>")
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>")
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<CR>")

-- local fzy = require("fzy")
--
-- vim.keymap.set("n", "<leader>ff", function()
-- 	fzy.execute("fd", fzy.sinks.edit_file)
-- end, { silent = true })
--
-- -- vim.keymap.set("n", "<leader>fg", function()
-- -- 	fzy.execute("git ls-files", fzy.sinks.edit_file)
-- -- end, { silent = true })
--
--
-- vim.keymap.set("n", "<leader>fl", function()
-- 	fzy.execute("ag --nobreak --noheading .", fzy.sinks.edit_live_grep)
-- end, { silent = true })

-- mostly native fzf alternative commands
-- vim.keymap.set("n", "<leader>ff", ":find <c-z>")
-- vim.keymap.set("n", "<leader>fg", ":grep ")
-- vim.keymap.set("n", "<leader>gf", "<cmd>GitQuickfix<cr>") -- TODO: implement the GitQuickfix function
-- vim.keymap.set("n", "<leader><leader>", ":buffer <c-z>")

vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>") -- alternatively  use nvim_create_user_command?

local function myFiles()
	local minifiles = require("mini.files")
	minifiles.open(vim.api.nvim_buf_get_name(0))
	minifiles.reveal_cwd()
end
vim.keymap.set("n", "<leader>e", myFiles)
-- vim.keymap.set("n", "<leader>e", "<cmd>Dirvish<CR>")

-- vim.keymap.set("n", "<leader>e", "<cmd>:Telescope file_browser path=%:p:h select_buffer=true<CR>")
vim.keymap.set("n", "gK", vim.diagnostic.open_float)
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition)
