return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.6',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		local wk = require("which-key")

		wk.register({
			f = {
				name = "Find",
				f = { builtin.find_files, "File" },
				g = { builtin.live_grep, "Live Grep" },
				b = { builtin.buffers, "Buffers" },
				h = { builtin.help_tags, "Help Tags" }
			}
		}, { prefix = "<leader>" })
	end
}
