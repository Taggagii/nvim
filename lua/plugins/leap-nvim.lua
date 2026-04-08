return {
	url = "https://codeberg.org/andyg/leap.nvim",
	lazy = false,
	config = function()
		require("leap").add_default_mappings()
    vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)', { silent = true, noremap = false })
    vim.keymap.set('n', 'S', '<Plug>(leap-from-window)', { silent = true, noremap = false })
	end
}
