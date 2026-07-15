-- Move through open windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus up window" })

-- Exit terminal mode with Esc
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Open or focus terminal at the bottom
vim.keymap.set("n", "<leader>t", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			vim.api.nvim_set_current_win(win)
			vim.cmd("startinsert")
			return
		end
	end
	vim.cmd("botright 15split | terminal")
	vim.cmd("startinsert")
end, { desc = "Focus or open terminal" })
