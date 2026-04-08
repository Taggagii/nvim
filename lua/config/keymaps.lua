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
	{ '<leader>f',  group = 'Find' },
	{ '<leader>ff', function() fzf.files() end,               desc = 'Search Files' },
	{ '<leader>fg', function() fzf.live_grep() end,           desc = 'Grep Files' },
	{ '<leader>fb', function() fzf.buffers() end,             desc = 'Search Buffers' },
	{ '<leader>fh', function() fzf.help_tags() end,           desc = 'Search Help Tags' },
	{ '<leader>fm', function() fzf.marks() end,               desc = 'Search Marks' },
	{ '<leader>fc', function() fzf.commands() end,            desc = 'Search Commands' },
	{ '<leader>fk', function() fzf.keymaps() end,             desc = 'Search Keymaps' },
	{ '<leader>fa', function() fzf.builtin() end,             desc = 'FzfLua Builtins' },
	{ '<leader>fs', "<CMD>AutoSession search<CR>",            desc = 'Search Session' },

	-- Code Companion
	{ "<leader>c",  group = "CodeCompanion" },
	{ "<leader>cc", "<cmd>CodeCompanionChat<cr>",             desc = "CodeCompanion Chat" },
	{ "<leader>ca", "<cmd>CodeCompanionActions<cr>",          desc = "CodeCompanion Actions" },
	{ "<leader>ce", "<cmd>CodeCompanion Explain<cr>",         mode = "v",                    desc = "Explain Selection" },
	{ "<leader>cf", "<cmd>CodeCompanion Fix<cr>",             mode = "v",                    desc = "Fix Selection" },

	-- Oil
	{ '<leader>e',  function() vim.cmd('Oil') end,            desc = 'Open File System' },

	-- Select all
	{ '<leader>a', "ggVG", desc = "Select all lines" },

	-- Style
	{ '<leader>s',  group = 'Style' },
	{ '<leader>sf', function() formatting.format_file() end,  desc = "Eslint Fix All" },
	{ '<leader>sa', function() vim.lsp.buf.code_action() end, desc = "Code Action" },
	
	{ '<leader>ss',  group = 'Spell Check' },
	{
		'<leader>sst',
		function()
			vim.wo.spell = not vim.wo.spell
			if vim.wo.spell then
				print("Spell check enabled")
			else
				print("Spell check disabled")
			end
		end,
		desc = "Toggle Spell Check"
	},
	{ '<leader>ssn', ']s', desc = "Next misspelled word" },
	{ '<leader>ssp', '[s', desc = "Previous misspelled word" },
	{ '<leader>sss', 'z=', desc = "Spelling suggestions" },
	{ '<leader>ssa', 'zg', desc = "Add word to dictionary" },
	{ '<leader>ssw', 'zw', desc = "Mark word as wrong" },

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

	-- We're not using this extension anymore
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
	{
		"<leader>mol",
		function()
			vim.cmd("term lazygit")
			vim.cmd("startinsert")
		end,
		desc = "Open current project in lazygit"
	},
	-- CoPilot [c]
	{ "<leader>moc", function() browser.open_url("https://github.com/copilot") end, desc = "Launch Github CoPilot" },
	-- Quickfix [q]
	{ "<leader>moq", function() vim.cmd("copen") end,                               desc = "Open Quickfix Window" },
	-- NoNeckPain [n]
	{ "<leader>mn",  group = "NoNeckPain" },
	{ "<leader>mnt", function() vim.cmd("NoNeckPain") end,                          desc = "Toggle NoNeckPain" },
	-- Session Management [s]
	{ "<leader>ms",  group = "Session Management" },
	{ "<leader>mss", "<CMD>AutoSession save<CR>",                                   desc = "Save Current Session" },
	{ "<leader>msS", function() autosession.save() end,                             desc = "Save Session with Custom Name" },

	-- Debugging
	{ "<leader>d",   group = "Debugging" },
	{ "<leader>db",  "<CMD>DapToggleBreakpoint<CR>",                                desc = "Toggle Breakpoint" },
	{ "<leader>dr",  "<CMD>DapContinue<CR>",                                        desc = "Run/Continue (then use r/i/O/o/b)" },

	-- Obsidian keymaps with proper groups
	{ "<leader>o",   group = "Obsidian" },
	{ "<leader>of",  function() vim.cmd("ObsidianSearch") end,                      desc = "Open Obsidian search" },
	{ "<leader>ow",  function() vim.cmd("ObsidianWorkspace") end,                   desc = "Open Workspace" },
	{ "<leader>oc",  group = "Checkbox" },
	{ "<leader>or", ":ObsidianRename ",                              mode = "n",                                 desc = "Rename current file" },
	-- todo : add more here (set to complete with one key)
	{ "<leader>ocy", "mz0f]hrx`z<CMD>:delmarks z<CR>",              desc = "Toggle Checkbox Done" },
	{ "<leader>ocn", "mz0f]hr `z<CMD>:delmarks z<CR>",              desc = "Toggle Checkbox Not Done" },
	-- { "<leader>or", function() vim.cmd("ObsidianQuickSwitch") end, desc = "Quick switch notes" },
	-- { "<leader>op",  ":ObsidianPasteImg",                                           desc = "Paste Image" }, -- warning: this doesn't work correctly
	{ "<leader>ob",  function() vim.cmd("ObsidianBacklinks") end,                   desc = "Show backlinks for current note" },
	{ 
		"<leader>os", 
		function()
			local cmd = "cd $HOME/obsidian && git add . && git commit -m 'adding notes' && git push"
			local result = vim.fn.system(cmd)
			print(result)  -- optional: prints the git output in a popup-style line
		end, 
		desc = "Git add, commit, and push current Obsidian vault" 
	},
	{ "<leader>ol",  group = "Link" },
	{ "<leader>oll", ":ObsidianLink ",                              mode = "v",                                 desc = "Link selected text (manual input)" },
	{ "<leader>ole", ":ObsidianExtractNote ",                       mode = "v",                                 desc = "Extract selected text to new note (manual input)" },
	{ "<leader>oln", ":ObsidianLinkNew ",                           mode = "v",                                 desc = "Create new link from selection (manual input)" },
	{ "<leader>olf", function() vim.cmd("ObsidianLinks") end,       desc = "Open link picker" },
	{ "<leader>on",  function() vim.cmd("ObsidianNew") end,         desc = "Create new note (prompt for title)" },
	{ "<leader>od",  group = "Dailies" },
	{ "<leader>odd", function() vim.cmd("ObsidianToday") end,       desc = "Open today's daily note" },
	{ "<leader>ody", function() vim.cmd("ObsidianYesterday") end,   desc = "Open yesterday's daily note" },
	{ "<leader>odt", function() vim.cmd("ObsidianTomorrow") end,    desc = "Open tomorrow's daily note" },
	{ "<leader>oq",  function() vim.cmd("ObsidianQuickSwitch") end, desc = "Quick switch notes" },

})
