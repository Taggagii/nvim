return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- LSP completions
    "hrsh7th/cmp-buffer",       -- buffer words
    "hrsh7th/cmp-path",         -- file paths
    "saadparwaiz1/cmp_luasnip", -- snippet completions
    "L3MON4D3/LuaSnip",         -- snippet engine
    "rafamadriz/friendly-snippets",
    "ray-x/lsp_signature.nvim", -- signature help 
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- load vscode-style snippets (friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    -- signature help (replaces blink's built-in one)
    require("lsp_signature").setup({
      hint_enable = false, -- cleaner UI
    })

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- enter to confirm 
        ["<C-Space>"] = cmp.mapping.complete(),             -- open completion
        ["<C-e>"] = cmp.mapping.abort(),                    -- close completion

        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),

        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        { name = "buffer" },
      }),

      completion = {
        completeopt = "menu,menuone,noinsert", -- similar feel to blink
      },

      window = {
        documentation = cmp.config.window.bordered(), -- manual docs feel
      },

      experimental = {
        ghost_text = false, -- blink-style (no inline ghost text)
      },

      sorting = {
        comparators = {
          cmp.config.compare.score,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.kind,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
    })
  end,
}
