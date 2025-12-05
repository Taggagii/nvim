return {
  "SirVer/ultisnips",
  dependencies = { "honza/vim-snippets" },
  event = "InsertEnter",
  lazy = false,
  init = function() 
      vim.g.UltiSnipsExpandTrigger = "<tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
  end
}
