require("config.keymaps")

vim.g.editorconfig = false

vim.cmd("set shiftwidth=4")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4 noexpandtab")
vim.cmd("set scrolloff=40")
vim.cmd("set ignorecase smartcase")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

vim.opt.clipboard:append("unnamedplus")

vim.cmd("set encoding=UTF-8")

-- Enable inline diagnostics and underlines globally
vim.diagnostic.config({
  virtual_text = true,   -- Show inline errors
  underline = true,     -- Underline errors
  signs = true,         -- Show signs in the gutter
  update_in_insert = false,
})

