local wk = require('which-key')
local oil = require("oil")
local harpoon = require("harpoon")

wk.add({
	-- Lazy stuff
	{ "<leader>l", "<cmd>Lazy<CR>", desc = "Lazy" }, -- moved to avoid conflict with LSP group

	-- Oil
	{ "<leader>e", "<cmd>Oil<CR>"},

	-- Buffer stuff
	{ "<leader>b", group = "Buffer" },
	{ "<leader>bd", "<cmd>bd<CR>", desc = "Close current buffer" },
	{ "<leader>q", group = "Quit" },
	{ "<leader>qw", "<cmd>wq<CR>", desc = "Write and close current file" },
	{ "<leader>qq", "<cmd>q<CR>", desc = "Quit the current file without saving" }, { "<leader>m", group = "Mason Stuff" },
	{ "<leader>mm", "<cmd>Mason<CR>", desc = "Open Mason Configuration" },
	{ "<leader>c", group = "Code Companion Stuff" },

	-- ESLint group and actions
	{ "<leader>s", group = "ESLint" },

	-- Format current file (using ESLint if it's set up as the formatter)
	{ "<leader>sf", function()
		vim.lsp.buf.format({ async = true })
	end, desc = "Format with ESLint" },

	-- Fix all fixable issues in the current file using ESLint
	{ "<leader>sfx", function()
		vim.lsp.buf.code_action({
			apply = true,
			context = {
				only = { "source.fixAll.eslint" },
				diagnostics = {},
			},
		})
	end, desc = "ESLint: Fix All" },

	-- Restart the ESLint language server (works if named 'eslint')
	{ "<leader>sr", function()
		vim.cmd('LspRestart eslint')
	end, desc = "Restart ESLint server" },

	-- Show floating diagnostics at cursor
	{ "<leader>sd", function()
		vim.diagnostic.open_float()
	end, desc = "Show ESLint diagnostics (float)" },

	-- Apply code action to disable rule for this line (if available)
	{ "<leader>si", function()
		vim.lsp.buf.code_action({
			filter = function(action)
				return action and action.title and action.title:lower():match("disable")
			end,
			apply = true
		})
	end, desc = "ESLint: Disable rule for this line (if available)" },

	-- Resizing splits
	{ "+", ":resize +2<CR>", desc = "Increase split height" },
	{ "_", ":resize -2<CR>", desc = "Decrease split height" },
	{ "=", ":vertical resize +2<CR>", desc = "Increase split width" },
	{ "-", ":vertical resize -2<CR>", desc = "Decrease split width" },

	-- LSP 
	{ "gD", vim.lsp.buf.definition, desc="Go to Global Definition"},

	-- Harpoon
	{ "<leader>h", group = "Harpoon" },
	{ "<leader>ha", function() require("harpoon"):list():add() end, desc = "harpoon file", },
	{ "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
	{ "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon to file 1", },
	{ "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon to file 2", },
	{ "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon to file 3", },
	{ "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon to file 4", },
	{ "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon to file 5", },

}, { prefix = "<leader>" })

-- my running mappings
function SetF5Mapping()
	local filetype = vim.bo.filetype
	if filetype == 'tex' then
		vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':VimtexCompile<CR>', { noremap = true, silent = true })
	elseif filetype == 'c' then -- todo : this doesn't work right
		vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':!gcc "%" -o "%:r.exe" && "%:r.exe"<CR>',
			{ noremap = true, silent = true })
	elseif filetype == 'python' then
		vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':w | !python3 "%"<CR>', { noremap = true })
	elseif filetype == 'markdown' then
		vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':MarkdownPreview<CR>', { noremap = true })
	elseif filetype == 'sh' then
		vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':!./"%"<CR>', { noremap = true })
	elseif filetype == 'st' then
		vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':!gst "%"<CR>', { noremap = true })
	else
		vim.api.nvim_buf_set_keymap(0, 'n', '<F5>',
			':echo "There isn\'t a mapping for the filetype \\"' .. filetype .. '\\""<CR>',
			{ noremap = true, silent = true })                                                                                                                  -- Do nothing for other filetypes
	end
end


-- calls a the above when a buffer is read or created
vim.cmd([[
  augroup SetF5Mappings
  autocmd!
  autocmd BufRead,BufNewFile * lua SetF5Mapping()
  augroup END
]])

-- control backspace
vim.keymap.set("i", "<C-H>", "<C-w>", { noremap = true, silent = true });

