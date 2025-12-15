return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require('lualine').setup({
			sections = {
				lualine_b = {},
				lualine_c = {
					{
						'filename',
						path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path, 3 = absolute with tilde for home
					}
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { 'branch' }
			},
			inactive_sections = {
				lualine_c = {
					{
						'filename',
						path = 1,
					}
				},
				lualine_x = {}
			}
		})
	end
}
