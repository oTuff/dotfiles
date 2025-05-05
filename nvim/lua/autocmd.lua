vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- set ansible filetype
-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "filetype" }, {
-- 	pattern = {
-- 		"*/playbooks/*.yml",
-- 		"*/roles/*/tasks/*.yml",
-- 		"*/playbooks/*.yaml",
-- 		"*/roles/*/tasks/*.yaml",
-- 		"*/Ansible/*.yml",
-- 		"*/Ansible/*.yaml",
-- 	},
-- 	callback = function()
-- 		vim.opt_local.filetype = "yaml.ansible"
-- 	end,
-- })
