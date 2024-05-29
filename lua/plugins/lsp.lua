return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'rafamadriz/friendly-snippets',
		'onsails/lspkind.nvim',
	},

	config = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				local opts = { buffer = event.buf }

				-- these will be buffer-local keybindings
				-- because they only work if you have an active language server

				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
				vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
				vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
				vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

				vim.keymap.set("n", "g]", vim.diagnostic.goto_next, {desc="Go to next warning"})
				vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, {desc="Go to previous warning"})

			end
		})

		local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

		local default_setup = function(server)
			require('lspconfig')[server].setup({
				capabilities = lsp_capabilities,
			})
		end

		require('mason').setup({})
		require('mason-lspconfig').setup({
			ensure_installed = {},
			handlers = {
				default_setup,
			},
		})

		require("luasnip.loaders.from_vscode").lazy_load()
		local cmp = require('cmp')
		local luasnip = require('luasnip')
		local lspkind = require('lspkind')

		lspkind.init({})

		cmp.setup({
			formatting = {
				format = lspkind.cmp_format({
					mode = 'symbol', -- show only symbol annotations
					maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					-- can also be a function to dynamically calculate max width such as
					-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
					ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default

					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
					before = function(entry, vim_item)
						return vim_item
					end
				})
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = {
				['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
				['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
				['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
				['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
				['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
			},
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			}, {
				{ name = 'buffer' },
			})
		})

		-- custom stuff goes here
		require('lspconfig').lua_ls.setup({
			capabilities = lsp_capabilities,
			settings = {
				Lua = {
					runtime = {
						version = 'LuaJIT'
					},
					diagnostics = {
						globals = { 'vim' },
					},
					workspace = {
						library = {
							vim.env.VIMRUNTIME,
						}
					}
				}
			}
		})
	end,
}
