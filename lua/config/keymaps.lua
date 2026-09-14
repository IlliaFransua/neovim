-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("x", "p", function()
	return 'pgv"' .. vim.v.register .. "y"
end, { expr = true, desc = "Paste without losing clipboard" })

vim.keymap.set("n", "x", [["_x]])
vim.keymap.set("x", "x", [["+x]])
vim.keymap.set({ "n", "x" }, "c", [["_c]])
vim.keymap.set({ "n", "x" }, "C", [["_C]])
vim.keymap.set({ "n", "x" }, "s", [["_s]])
vim.keymap.set({ "n", "x" }, "S", [["_S]])
vim.keymap.set("x", "d", [["_d]])
vim.keymap.set("x", "D", [["_D]])
vim.keymap.set('n', '<leader>az', function() vim.b.autoformat = not vim.b.autoformat end, { desc = "toggle autoformat" })

vim.keymap.set("n", "<leader>cy", function()
	local d = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })[1]
	if d then
		vim.fn.setreg("+", d.message)
	end
end, { desc = "Yank diagnostic" })
