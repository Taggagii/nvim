require("config.keymaps")

vim.g.editorconfig = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = 'number'

vim.opt.clipboard:append('unnamedplus')

local indentAmount = 4

vim.opt.tabstop = indentAmount
vim.opt.shiftwidth = indentAmount
vim.opt.softtabstop = indentAmount
vim.opt.expandtab = false

