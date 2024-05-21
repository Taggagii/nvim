return {
	"tpope/vim-fugitive",
	config = function()
		local wk = require("which-key")

		wk.register({
			g = {
				name = "Git",
				s = { vim.cmd.Git, "Open git information" }
			}
		}, { prefix = "<leader>" })
	end
}
