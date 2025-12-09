-- return {
-- 	"stevearc/quicker.nvim",
-- 	opts = {},
-- 	config = function()
-- 		require('quicker').setup()
-- 	end
-- }

return {
	"kevinhwang91/nvim-bqf",
	event = "VeryLazy", -- You can change this event as needed
	config = function()
		require("bqf").setup()
	end,
}
