return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate'
}

-- return {
-- 	'nvim-treesitter/nvim-treesitter',
-- 	build = ":TSUpdate",
-- 	config = function()
-- 		require("nvim-treesitter.install").compilers = { "zig", "clang" }
--
-- 		local configs = require("nvim-treesitter.configs")
--
-- 		configs.setup({
-- 			ensure_installed = { },
-- 			sync_install = false,
-- 			highlight = { enable = true },
-- 			indent = { enable = true },
-- 		})
-- 	end
-- }
