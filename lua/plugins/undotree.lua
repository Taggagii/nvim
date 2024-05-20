return {
	"mbbill/undotree",
	config = function()
		local wk = require('which-key')

		vim.g.undotree_DiffCommand = "FC"

		wk.register({
			u = { vim.cmd.UndotreeToggle, "Toggle Undotree" }
		}, { prefix = "<leader>" })
	end
}
