local wk = require('which-key')

-- that alt move behaviour
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- floating terminal
vim.keymap.set("n", "<C-_>", ":FloatermToggle<CR>")
vim.keymap.set("t", "<C-_>", "<C-\\><C-n>:FloatermToggle<CR>")

wk.register({
	-- e = { vim.cmd.Ex, "Explorer" },
	l = { ":Lazy<CR>", "Lazy" },
}, { prefix = "<leader>" })
