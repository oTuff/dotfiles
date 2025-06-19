vim.opt.list = true
vim.opt.listchars = {
	-- tab = "▏ ",
	-- leadmultispace = "▏ ",
	trail = "·",
	extends = "»",
	precedes = "«",
}

-- TODO: handle case where expandtab is true but shiftwidth is 0 (should use the tabstop instead)
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("indent-char", { clear = true }),
	pattern = "*",
	callback = function()
		if vim.bo.expandtab == true then
			vim.opt_local.listchars:append({
				leadmultispace = "▏" .. string.rep(" ", vim.bo.shiftwidth - 1),
			})
		else
			vim.opt_local.listchars:append({ tab = "▏ " })
		end
	end,
})
