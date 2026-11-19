-- Useful keymaps registered with which-key format

local fzf = require('fzf-lua')
local wk = require('which-key')
local browser = require('helpers.browser')
local formatting = require('helpers.formatting')
local autosession = require('helpers.autosession')
local zoom = require('helpers.zoom')

-- control backspace
vim.keymap.set("i", "<C-H>", "<C-w>", { noremap = true, silent = true });

wk.add({
	-- Sidekick: jump to / apply Copilot Next Edit Suggestion, falling back to a normal <Tab>
	{
		"<Tab>",
		function()
			if not require("sidekick").nes_jump_or_apply() then
				return "<Tab>"
			end
		end,
		mode = { "n", "i" },
		expr = true,
		desc = "Goto/Apply Next Edit Suggestion",
	},
	-- Find
	{ '<leader>f',  group = 'Find' },
	{ '<leader>ff', function() fzf.files() end,               desc = 'Search Files' },
	{ '<leader>fF', function() fzf.files({ hidden = true, no_ignore = true }) end, desc = 'Search Files (include hidden)' },
	{ '<leader>fg', function() fzf.live_grep() end,           desc = 'Grep Files' },
	{ '<leader>fg', function() fzf.grep_visual() end,         mode = 'x', desc = 'Grep Selected Text' },
	{ '<leader>fG', function() fzf.live_grep({ hidden = true, no_ignore = true }) end, desc = 'Grep Files (include hidden)' },
	{ '<leader>fb', function() fzf.buffers() end,             desc = 'Search Buffers' },
	{ '<leader>fh', function() fzf.help_tags() end,           desc = 'Search Help Tags' },
	{ '<leader>fm', function() fzf.marks() end,               desc = 'Search Marks' },
	{ '<leader>fc', function() fzf.commands() end,            desc = 'Search Commands' },
	{ '<leader>fk', function() fzf.keymaps() end,             desc = 'Search Keymaps' },
	{ '<leader>fa', function() fzf.builtin() end,             desc = 'FzfLua Builtins' },
	{ '<leader>fs', "<CMD>AutoSession search<CR>",            desc = 'Search Session' },

	-- Oil
	{ '<leader>e',  function() vim.cmd('Oil') end,            desc = 'Open File System' },

	-- Sidekick (AI CLI + Next Edit Suggestions)
	{ "<leader>a",  group = "Sidekick AI" },
	{ "<leader>aa", function() require("sidekick.cli").toggle() end,             desc = "Toggle Copilot CLI" },
	{ "<leader>as", function() require("sidekick.cli").select({ auto = true }) end, desc = "Attach Copilot CLI" },
	{ "<leader>ad", function() require("sidekick.cli").close() end,              desc = "Detach CLI Session" },
	{ "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end,      mode = { "n", "x" }, desc = "Send This" },
	{ "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end,      desc = "Send File" },
	{ "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, mode = { "x" },      desc = "Send Visual Selection" },
	{ "<leader>ap", function() require("sidekick.cli").prompt() end,             mode = { "n", "x" }, desc = "Select Prompt" },
	{
		"<leader>an",
		function()
			require("sidekick.nes").toggle()
			print("Sidekick NES suggestions " .. (require("sidekick.nes").enabled and "enabled" or "disabled"))
		end,
		desc = "Toggle Next Edit Suggestions",
	},

	-- Select all
	{ '<leader>v',  group = 'View/Select' },
	{ '<leader>va', "ggVG", desc = "Select all lines" },

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
	{ "<leader>xa",   function() vim.lsp.buf.code_action() end,                                           desc = "Code Action (Fix)", },

	-- Resizing splits (supports count, e.g. 5+ resizes by 5*2)
	{ "+",            function() vim.cmd("resize +" .. (vim.v.count1 * 2)) end,                           desc = "Increase split height" },
	{ "_",            function() vim.cmd("resize -" .. (vim.v.count1 * 2)) end,                           desc = "Decrease split height" },
	{ "=",            function() vim.cmd("vertical resize +" .. (vim.v.count1 * 2)) end,                  desc = "Increase split width" },
	{ "-",            function() vim.cmd("vertical resize -" .. (vim.v.count1 * 2)) end,                  desc = "Decrease split width" },
	{ "<C-w>z",       zoom.toggle,                                                                       desc = "Toggle window zoom" },

	-- LSP
	{ "gD",           function() fzf.lsp_definitions({ jump1 = true }) end,                               desc = "Go to Definition" },

	-- Misc
	{ "<leader>m",    group = "Misc" },

	-- Folding [f]
	{
		'<leader>mf',
		function()
			if vim.fn.foldclosed('.') ~= -1 then
				vim.cmd('normal! zo')
			else
				-- Manual mode preserves existing folds and allows folding an exact pair.
				vim.wo.foldmethod = 'manual'
				vim.wo.foldenable = true
				vim.cmd('normal zf%')
			end
		end,
		desc = "Fold tag/bracket pair or open fold",
	},

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
			local win, buf = vim.api.nvim_get_current_win(), vim.api.nvim_get_current_buf()
			vim.cmd("hide enew")
			vim.fn.termopen("lazygit", {
				on_exit = function()
					vim.schedule(function()
						vim.api.nvim_win_set_buf(win, buf)
					end)
				end,
			})
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
