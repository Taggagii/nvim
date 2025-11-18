local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	command = "setlocal formatoptions-=o formatoptions-=r",
});

require("lazy").setup("plugins")
require("config")

-- vim.cmd("colorscheme vscode")
vim.cmd("colorscheme kanagawa-dragon")
-- vim.cmd("colorscheme kanagawa-wave")
-- vim.cmd("colorscheme kanagawa-lotus")
