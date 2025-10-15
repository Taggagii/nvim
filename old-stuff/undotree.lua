return {
	"mbbill/undotree",
	config = function()
		local wk = require('which-key')

		vim.g.undotree_DiffCommand = "FC"

		wk.add({
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle Undotree" },
		})
	end
}
