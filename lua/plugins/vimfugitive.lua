return {
	"tpope/vim-fugitive",
	config = function()
		local wk = require("which-key")

		wk.add({
			{ "<leader>g", group = "Git" },
			{ "<leader>gs", vim.cmd.Git, desc = "Open git information" },
			{ "<leader>gd", ":Gdiff<CR>", desc = "Open a merge split" },
			{ "<leader>gD", ":Gdiffsplit!<CR>", desc = "Open a three way merge split" },
		})
	end
}
