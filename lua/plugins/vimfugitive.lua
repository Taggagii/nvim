return {
	"tpope/vim-fugitive",
	config = function()
		local wk = require("which-key")

		wk.register({
			g = {
				name = "Git",
				s = { vim.cmd.Git, "Open git information" },
				d = { ":Gdiff<CR>", "Open a merge split" },
				D = { ":Gdiffsplit!<CR>", "Open a three way merge split" }
			}
		}, { prefix = "<leader>" })
	end
}
