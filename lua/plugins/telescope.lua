-- REMEMBER TO DOWNLOAD RIPGREP!!!
-- IT IGNORES YOUR .GITIGNORE
return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.6',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		local wk = require("which-key")

		-- wk.register({
		-- 	f = {
		-- 		name = "Find",
		-- 		f = { builtin.find_files, "File" },
		-- 		g = { builtin.live_grep, "Live Grep" },
		-- 		b = { builtin.buffers, "Buffers" },
		-- 		h = { builtin.help_tags, "Help Tags" }
		-- 	},
		-- 	[","] = { builtin.buffers, "Search Buffers" }
		-- }, { prefix = "<leader>" })

		wk.add({
			{ "<leader>,", builtin.buffers, desc = "Search Buffers" },
			{ "<leader>f", group = "Find" },
			{ "<leader>fb", builtin.buffers, desc = "Buffers" },
			{ "<leader>ff", builtin.find_files, desc = "File" },
			{ "<leader>fg", builtin.live_grep, desc = "Live Grep" },
			{ "<leader>fh", builtin.help_tags, desc = "Help Tags" },
		})
	end
}
