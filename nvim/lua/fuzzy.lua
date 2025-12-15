-- Modified version of: https://www.chrisdeluca.me/2022/01/12/diy-neovim-fzy.html
-- TODO:
-- - [ ] read [`vim.fn.jobstart`] documentation and improve this!
-- - [ ] should just get the output directly instead of writing to a temp file
-- 	 or should write to ~/.local/share/nvim similar to telescope_history with a limit of 100 entries
-- TODO: need more pickers
-- - [x] files
-- - [ ] git files: `git status --porcelain`
-- - [ ] buffers
-- - [ ] marks
-- - [ ] old files
-- - [ ] search history
-- - [ ] grep(ripgrep) `rg --line-number --no-heading --hidden --glob '!.git/*' ''` (should probably be a bit smarter - only run grep with some initial input?)
-- TODO: should the it also expose a `Fzy` command that can be called from command mode?
local M = {}
M.FuzzySearch = function()
	local width = vim.o.columns - 4
	if vim.o.columns >= 85 then
		width = 80
	end
	local height = 11

	vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), true, {
		relative = "editor",
		title = " Fuzzy File Search ", -- TODO: dynamic title
		title_pos = "center",
		border = "single",
		noautocmd = true,
		width = width,
		height = height,
		col = math.min((vim.o.columns - width) / 2),
		row = math.min((vim.o.lines - height) / 2 - 1),
	})
	vim.cmd.startinsert()

	local file = vim.fn.tempname()
	vim.fn.jobstart("fd -t f | fzy > " .. file, { -- TODO: dynamic command input
		term = true,
		on_exit = function()
			vim.cmd.bdelete()
			local f = assert(io.open(file, "r"))
			local stdout = f:read("*all")
			f:close()
			os.remove(file)
			local selected = stdout:gsub("%s+", "") -- TODO: dynamic matching based on the stdout
			-- TODO: optional specify location in file(line number from ripgrep)
			if vim.loop.fs_stat(selected) then
				vim.cmd.edit(selected)
			end
		end,
	})
end
return M
