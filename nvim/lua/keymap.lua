vim.g.mapleader = " "
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- or just use ctrl+l

-- Telescope
-- vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>ff", require("fuzzy").FuzzySearch)
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>Telescope git_status<CR>")
vim.keymap.set("n", "<leader><leader>", function()
	require("telescope.builtin").buffers({ sort_lastused = true })
end)
vim.keymap.set("n", "<leader>fm", "<cmd>Telescope marks<CR>")
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>")
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope grep_string<CR>")

-- mostly native fzf alternative commands
-- vim.keymap.set("n", "<leader>ff", ":find <c-z>")
-- vim.keymap.set("n", "<leader>fg", ":grep ")
-- vim.keymap.set("n", "<leader><leader>", ":buffer <c-z>")

local function myFiles()
	local minifiles = require("mini.files")
	minifiles.open(vim.api.nvim_buf_get_name(0))
	minifiles.reveal_cwd()
end
vim.keymap.set("n", "<leader>e", myFiles)
-- vim.keymap.set("n", "<leader>e", "<cmd>Dirvish<CR>")
-- vim.keymap.set("n", "<leader>e", "<cmd>:Telescope file_browser path=%:p:h select_buffer=true<CR>")
--
vim.keymap.set("n", "gK", vim.diagnostic.open_float)
vim.keymap.set("n", "grt", vim.lsp.buf.type_definition)
