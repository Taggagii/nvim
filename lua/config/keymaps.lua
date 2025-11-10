-- Useful keymaps registered with which-key format
local wk = require('which-key')

wk.add({
	-- Find
	{ '<leader>f', group = 'FzfLua' },
	{ '<leader>ff', function() vim.cmd('FzfLua files') end, desc = 'Search Files' },
	{ '<leader>fg', function() vim.cmd('FzfLua live_grep') end, desc = 'Grep Files' },
	{ '<leader>fb', function() vim.cmd('FzfLua buffers') end, desc = 'Search Buffers' },
	{ '<leader>fh', function() vim.cmd('FzfLua help_tags') end, desc = 'Search Help Tags' },
	{ '<leader>fm', function() vim.cmd('FzfLua marks') end, desc = 'Search Marks' },
	{ '<leader>fc', function() vim.cmd('FzfLua commands') end, desc = 'Search Commands' },
	{ '<leader>fk', function() vim.cmd('FzfLua keymaps') end, desc = 'Search Keymaps' },
	{ '<leader>fa', function() vim.cmd('FzfLua builtin') end, desc = 'FzfLua Builtins' },

	-- Oil
	{ '<leader>e', function() vim.cmd('Oil') end, desc = 'Open File System' },

	-- Style
	{ '<leader>s', group='Style' },
	{ '<leader>sf', function() vim.cmd('LspEslintFixAll') end, desc = 'Eslint Fix All' }
})
