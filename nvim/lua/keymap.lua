vim.g.mapleader = " "
-- vim.keymap.set("i", "<C-space>", "<C-x><C-o>") -- use vim.lsp.completion.trigger instead
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- or just use ctrl+l
-- maybe just make neovim yank to system clipboard or just remove some or some other solution ?
vim.keymap.set("n", "<leader>y", '"+y', { noremap = true })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true })
vim.keymap.set("n", "<leader>Y", '"+y$', { noremap = true })
vim.keymap.set("n", "<leader>d", '"_d', { noremap = true })
vim.keymap.set("n", "<leader>D", '"_d$', { noremap = true })
-- fzf
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<leader>gf", "<cmd>FzfLua git_status<CR>")
vim.keymap.set("n", "<leader>b", "<cmd>b#<CR>")
-- mostly native fzf alternative commands
-- vim.keymap.set("n", "<leader>ff", ":find <c-z>")
-- vim.keymap.set("n", "<leader>fg", ":grep ")
-- vim.keymap.set("n", "<leader><leader>", ":buffer <c-z>")
-- vim.keymap.set("n", "<leader>gf", "<cmd>GitQuickfix<cr>")

-- gitsigns
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>")
-- vim.keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
-- vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>")
-- vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")

vim.keymap.set("n", "gT", vim.lsp.buf.type_definition)
vim.api.nvim_create_user_command("Le", "NvimTreeToggle", {})
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>")
vim.keymap.set("n", "<leader>se", vim.diagnostic.open_float)
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- default in neovim 0.11:
vim.keymap.set("n", "grr", vim.lsp.buf.references)
vim.keymap.set("n", "grn", vim.lsp.buf.rename)
vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
vim.keymap.set("n", "]q", "<cmd>cn<cr>")
vim.keymap.set("n", "[q", "<cmd>cp<cr>")
vim.keymap.set("n", "]b", "<cmd>bn<cr>")
vim.keymap.set("n", "[b", "<cmd>bp<cr>")
