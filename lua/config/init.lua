require("config.keymaps")

-- for config to not do silly things
vim.g.editorconfig = false

-- for left numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

-- for copying
vim.opt.clipboard:append('unnamedplus')

-- for matting
local indentAmount = 4
vim.opt.tabstop = indentAmount
vim.opt.shiftwidth = indentAmount
vim.opt.softtabstop = indentAmount
vim.opt.expandtab = false
vim.opt.wrap = false

-- for searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- for folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- for session manager
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
