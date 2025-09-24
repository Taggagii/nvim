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
			update_focused_file = {
				enable = true,
				update_root = false, -- Set to true to set tree root as well
			},
		})
	end

}
