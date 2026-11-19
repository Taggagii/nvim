require("config.keymaps")
require("config.autocmds")
local os = require("helpers.os")

vim.g.editorconfig = true

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
end
vim.opt.clipboard = "unnamedplus"

-- Fallback indentation; EditorConfig and vim-sleuth override this per buffer.
vim.opt.tabstop = 8
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1

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
-- for obsidian this needs to be 2
vim.opt.conceallevel = 0
