require("config.keymaps")

vim.cmd("set shiftwidth=4")
vim.cmd("set tabstop=4")
vim.cmd("set scrolloff=40")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

vim.opt.clipboard:append("unnamedplus")
