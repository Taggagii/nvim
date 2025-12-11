-- Useful keymaps registered with which-key format

local fzf = require('fzf-lua')
local wk = require('which-key')
local browser = require('helpers.browser')
local formatting = require('helpers.formatting')
local autosession = require('helpers.autosession')

-- control backspace
vim.keymap.set("i", "<C-H>", "<C-w>", { noremap = true, silent = true });

wk.add({
	-- Find
	{ '<leader>f',    group = 'Find' },
	{ '<leader>ff',   function() fzf.files() end,                                                         desc = 'Search Files' },
	{ '<leader>fg',   function() fzf.live_grep() end,                                                     desc = 'Grep Files' },
	{ '<leader>fb',   function() fzf.buffers() end,                                                       desc = 'Search Buffers' },
	{ '<leader>fh',   function() fzf.help_tags() end,                                                     desc = 'Search Help Tags' },
	{ '<leader>fm',   function() fzf.marks() end,                                                         desc = 'Search Marks' },
	{ '<leader>fc',   function() fzf.commands() end,                                                      desc = 'Search Commands' },
	{ '<leader>fk',   function() fzf.keymaps() end,                                                       desc = 'Search Keymaps' },
	{ '<leader>fa',   function() fzf.builtin() end,                                                       desc = 'FzfLua Builtins' },
	{ '<leader>fs',   "<CMD>AutoSession search<CR>",                                                      desc = 'Search Session' },

	-- Oil
	{ '<leader>e',    function() vim.cmd('Oil') end,                                                      desc = 'Open File System' },

	-- Style
	{ '<leader>s',    group = 'Style' },
	{ '<leader>sf',   function() formatting.format_file() end,                                            desc = "Eslint Fix All" },
	{ '<leader>sa',   function() vim.lsp.buf.code_action() end,                                           desc = "Code Action" },

	-- Diagnostics
	{ "<leader>x",    group = "Diagnostics" },
	{ "<leader>xx",   "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",                                 desc = "Buffer Diagnostics", },
	{ "<leader>xX",   "<cmd>Trouble diagnostics toggle<cr>",                                              desc = "Diagnostics", },

	-- Resizing splits
	{ "+",            ":resize +2<CR>",                                                                   desc = "Increase split height" },
	{ "_",            ":resize -2<CR>",                                                                   desc = "Decrease split height" },
	{ "=",            ":vertical resize +2<CR>",                                                          desc = "Increase split width" },
	{ "-",            ":vertical resize -2<CR>",                                                          desc = "Decrease split width" },

	-- LSP
	{ "gD",           function() fzf.lsp_definitions({ jump1 = true }) end,                               desc = "Go to Definition" },

	-- Misc
	{ "<leader>m",    group = "Misc" },
	-- Markdown Viewing [m]
	{ "<leader>mm",   group = "Markdown" },
	{ "<leader>mmp",  "<CMD>MarkdownPreviewToggle<CR>",                                                   desc = "Toggle Markdown Preview" },
	-- Highlighting [h]
	{ "<leader>mh",   group = "Highlighting" },
	{ "<leader>mhc",  "<CMD>noh<CR>",                                                                     desc = "Clear highlights" },
	-- Word Wrap [w]
	{ "<leader>mw",   group = "Word wrap" },
	{ "<leader>mwy",  "<CMD>set wrap<CR>",                                                                desc = "Turn on Word Wrap" },
	{ "<leader>mwn",  "<CMD>set nowrap<CR>",                                                              desc = "Turn off Word Wrap" },
	-- Open [o]
	{ "<leader>mo",   group = "Open" },
	-- File [f]
	{ "<leader>mof",  group = "File" },
	{ "<leader>mofc", function() vim.cmd('!code ' .. vim.fn.getcwd() .. ' ' .. vim.fn.expand('%:p')) end, desc = "Open File in VSCode (project root)" },
	-- Folder [F]
	{ "<leader>moF",  group = "Folder" },
	{ "<leader>moFc", function() vim.cmd('!code ' .. vim.fn.getcwd()) end,                                desc = "Open Project Folder in VSCode" },
	-- LazyGit [l]
	{ "<leader>mol",  "<CMD>term lazygit<CR>",                                                            desc = "Open current project in lazygit" },
	-- CoPilot [c]
	{ "<leader>moc",  function() browser.open_url("https://github.com/copilot") end,                      desc = "Launch Github CoPilot" },
	-- Quickfix [q]
	{ "<leader>moq",  function() vim.cmd("copen") end,                                                    desc = "Launch Github CoPilot" },
	-- NoNeckPain [n]
	{ "<leader>mnt", group = "NoNeckPain"},
	{ "<leader>mnt", function() vim.cmd("NoNeckPain") end, desc = "Toggle NoNeckPain"},


	-- Session Management [s]
	{ "<leader>ms",   group = "Session Management" },
	{ "<leader>mss",  "<CMD>AutoSession save<CR>",                                                        desc = "Save Current Session" },
	{ "<leader>msS",  function() autosession.save() end,                                                  desc = "Save Session with Custom Name" },

	-- Debugging
	{ "<leader>d",    group = "Debugging" },
	{ "<leader>db",   "<CMD>DapToggleBreakpoint<CR>",                                                     desc = "Toggle Breakpoint" },
	{ "<leader>dr",   "<CMD>DapContinue<CR>",                                                             desc = "Run/Continue (then use r/i/O/o/b)" },
})
