return {
  "esmuellert/nvim-eslint",
  ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "astro" },  -- filetypes you want
  config = function()
    require("nvim-eslint").setup({
      -- optional override settings
      debug = false,
      -- … other settings
    })
  end,
}
