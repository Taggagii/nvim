return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        {
			"mason-org/mason.nvim",
			opts = {
				ensure_installed = {
					"prettier",
					"js-debug-adapter"
				}
			}
		},
		"neovim/nvim-lspconfig",
	},
	config = function() 
		local config = require('mason-lspconfig')
		config.setup {
			ensure_installed = { 'ts_ls', 'eslint' }
		}

	end

}
