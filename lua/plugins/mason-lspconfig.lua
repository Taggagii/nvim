return {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        {
			"mason-org/mason.nvim",
			opts = {
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry", -- provides roslyn
				},
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
        	ensure_installed = { }
        }

        -- Copilot LSP powers Sidekick's Next Edit Suggestions. Mason's registry
        -- currently pins a pulled npm version, so install it manually instead:
        --   npm install -g @github/copilot-language-server
        vim.lsp.enable('copilot')
	end

}
