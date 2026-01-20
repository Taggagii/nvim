return {
  "olimorris/codecompanion.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",

    -- REQUIRED for Copilot adapter
    "github/copilot.vim",
  },
  config = function()
    local adapters = require("codecompanion.adapters")

    require("codecompanion").setup({
      adapters = {
        -- Ollama (local models)
        ollama = function()
          return adapters.extend("ollama", {
            schema = {
              model = {
                default = "llama3.1:8b",
              },
            },
          })
        end,

        -- GitHub Copilot
        copilot = function()
          return adapters.extend("copilot", {})
        end,
      },
      strategies = {
        -- Example split:
        chat   = { adapter = "ollama" },   -- long-form, private, local
        inline = { adapter = "copilot" },  -- fast completions
        agent  = { adapter = "ollama" },
      },

      opts = {
        log_level = "ERROR",
      },
    })
  end,
}
