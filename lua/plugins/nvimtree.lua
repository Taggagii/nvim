return {
	'nvim-tree/nvim-tree.lua',
	module = false,
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		vim.opt.termguicolors = true

        require("nvim-tree").setup({
            filters = {
                dotfiles = false,
            },
        })
	end

}
