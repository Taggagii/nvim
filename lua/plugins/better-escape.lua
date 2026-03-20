-- This seems like a cool idea to still have caps lock and not have to worry about rebinding stuff
return {
	"max397574/better-escape.nvim",
	config = function()
		require("better_escape").setup()
	end,
}
