return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

		require('mason').setup()
		require('mason-lspconfig').setup({
			ensure_installed = {
				"ts_ls",
				"pyright",
			},
			handlers = {
				function(server)
					require('lspconfig')[server].setup({
						capabilities = lsp_capabilities,
					})
				end,
			},
		})
	end,
}
