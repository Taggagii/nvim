require("config.keymaps")
local os = require("helpers.os")

-- for config to not do silly things
vim.g.editorconfig = false

-- for left numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'

-- for copying
local system = os.detect_os()
if system == "windows" or system == "wsl" then
  vim.g.clipboard = {
    name = "win32yank",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
	vim.opt.clipboard = "unnamedplus"
end

-- for matting
local indentAmount = 2
vim.opt.tabstop = indentAmount
vim.opt.shiftwidth = indentAmount
vim.opt.softtabstop = indentAmount
-- vim.opt.expandtab = false

-- for wrapping
vim.opt.wrap = true

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

-- for splitting 
vim.opt.splitright = true

-- for spelling
vim.opt.spell = false -- we'll set this with a keybind
vim.opt.spelllang = { "en_ca" }

-- for centering (this is actually really annoying)
-- vim.opt.scrolloff = 999
