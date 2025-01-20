vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- change the listchar for leadmultispace for filetypes with shiftwidth of 4.
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	group = vim.api.nvim_create_augroup("LeadMultiSpaceListChar", { clear = true }),
	pattern = "*",
	callback = function()
		if vim.bo.shiftwidth == 4 then
			vim.opt_local.listchars:append({ leadmultispace = "▏   " })
		end
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
-- 		vim.bo.filetype = "yaml.ansible"
-- 	end,
-- })

