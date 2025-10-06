return {
	"Djancyp/better-comments.nvim",
	config = function()
		require("better-comment").Setup({
			tags = {
				{
					name = "todo",
					fg = "black",
					bg = "yellow",
					bold = true,
					virtual_text = "",
				},
				{
					name = "!",
					fg = "#f44747",
					bg = "",
					bold = true,
					virtual_text = "",
				},
				{
					name = "?",
					fg = "#add8e6",
					bg = "",
					bold = true,
					virtual_text = "",
				},
				{
					name = "*",
					fg = "yellow",
					bg = "",
					bold = true,
					virtual_text = "",
				}
			}

		})
	end
}

-- todo : something that I need to do
-- ? : some question
-- ! : this should be fixed
-- * : pay attention
