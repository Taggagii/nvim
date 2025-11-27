-- Useful keymaps registered with which-key format

local fzf = require('fzf-lua')
local wk = require('which-key')

-- control backspace
vim.keymap.set("i", "<C-H>", "<C-w>", { noremap = true, silent = true });

wk.add({
    -- Find
    { '<leader>f', group = 'FzfLua' },
    { '<leader>ff', function() fzf.files() end, desc = 'Search Files' },
    { '<leader>fg', function() fzf.live_grep() end, desc = 'Grep Files' },
    { '<leader>fb', function() fzf.buffers() end, desc = 'Search Buffers' },
    { '<leader>fh', function() fzf.help_tags() end, desc = 'Search Help Tags' },
    { '<leader>fm', function() fzf.marks() end, desc = 'Search Marks' },
    { '<leader>fc', function() fzf.commands() end, desc = 'Search Commands' },
    { '<leader>fk', function() fzf.keymaps() end, desc = 'Search Keymaps' },
    { '<leader>fa', function() fzf.builtin() end, desc = 'FzfLua Builtins' },

    -- Oil
    { '<leader>e', function() vim.cmd('Oil') end, desc = 'Open File System' },

    -- Style
    { '<leader>s', group='Style' },
    { '<leader>sf', function() vim.cmd('LspEslintFixAll') end, desc="Eslint Fix All" },

    -- Trouble
    { "<leader>x", group="Diagnostics" },
    { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics", },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics", },

	-- Resizing splits
	{ "+", ":resize +2<CR>", desc = "Increase split height" },
	{ "_", ":resize -2<CR>", desc = "Decrease split height" },
	{ "=", ":vertical resize +2<CR>", desc = "Increase split width" },
	{ "-", ":vertical resize -2<CR>", desc = "Decrease split width" },

	-- LSP 
	{ "gD", vim.lsp.buf.definition, desc="Go to Global Definition"},

	-- Hide highlighting
	{ "<leader>h", group="Highlighting" },
	{ "<leader>hc", "<CMD>noh<CR>", desc="Clear highlights" },

	-- Word Wrap
	{ "<leader>w", group="Word wrap" },
	{ "<leader>wy", "<CMD>set wrap<CR>", desc="Turn on Word Wrap" },
	{ "<leader>wn", "<CMD>set nowrap<CR>", desc="Turn off Word Wrap" },

	-- Markdown Viewing
	{ "<leader>m", group="Markdown" },
	{ "<leader>mp", "<CMD>MarkdownPreviewToggle<CR>", desc="Toggle Markdown Preview" },

	-- Debugging 
	{ "<leader>d", group="Debugging" },
	{ "<leader>db", "<CMD>DapToggleBreakpoint<CR>", desc="Toggle Breakpoint" },
	{ "<leader>dr", "<CMD>DapContinue<CR>", desc="Run or Continue the Debugger" },
	{ "<leader>di", "<CMD>DapStepInto<CR>", desc="Step Into" },
	{ "<leader>dO", "<CMD>DapStepOut<CR>", desc="Step Out" },
	{ "<leader>do", "<CMD>DapStepOver<CR>", desc="Step Over" },
})
