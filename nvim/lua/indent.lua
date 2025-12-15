local indent_char = "▏"

vim.opt.list = true
vim.opt.listchars = {
	tab = indent_char .. " ",
	trail = "·",
	extends = "»",
	precedes = "«",
}

vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("indent-char", { clear = true }),
	pattern = "*",
	callback = function()
		if vim.bo.expandtab == true then
			if vim.bo.shiftwidth > 0 then
				vim.opt_local.listchars:append({
					leadmultispace = indent_char .. string.rep(" ", vim.bo.shiftwidth - 1),
				})
			else
				vim.opt_local.listchars:append({
					leadmultispace = indent_char .. string.rep(" ", vim.bo.tabstop - 1),
				})
			end
		end
	end,
})
