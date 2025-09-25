local wk = require('which-key')
local telescope_builtin = require('telescope.builtin')
local oil = require("oil")

wk.add({
	-- Lazy stuff
	{ "<leader>l", "<cmd>Lazy<CR>", desc = "Lazy" }, -- moved to avoid conflict with LSP group

	-- NvimTree
	-- { "<leader>e", function()
	-- 	local ok, nvimtree = pcall(require, "nvim-tree.api")
	-- 	if ok and nvimtree then
	-- 		nvimtree.tree.toggle()
	-- 	else
	-- 		vim.notify("nvim-tree is not loaded", vim.log.levels.WARN)
	-- 	end
	-- end, desc = "Toggle Explorer" },

	-- Oil
	{ "<leader>e", "<cmd>Oil<CR>"},

	-- Buffer stuff
	{ "<leader>b", group = "Buffer" },
	{ "<leader>bd", "<cmd>bd<CR>", desc = "Close current buffer" },
	{ "<leader>q", group = "Quit" },
	{ "<leader>qw", "<cmd>wq<CR>", desc = "Write and close current file" },
	{ "<leader>qq", "<cmd>q<CR>", desc = "Quit the current file without saving" },
	{ "<leader>m", group = "Mason Stuff" },
	{ "<leader>mm", "<cmd>Mason<CR>", desc = "Open Mason Configuration" },
	{ "<leader>c", group = "Code Companion Stuff" },

	-- ESLint group and actions (now under <leader>s)
	{ "<leader>s", group = "ESLint" },
	{ "<leader>sf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format with ESLint" },
	{ "<leader>sfx", function() vim.lsp.buf.execute_command({ command = "eslint.applyAllFixes" }) end, desc = "ESLint: Fix All" },
	{ "<leader>sr", function() vim.cmd('LspRestart eslint') end, desc = "Restart ESLint server" },
	{ "<leader>sd", function() vim.diagnostic.open_float() end, desc = "Show ESLint diagnostics (float)" },
	{ "<leader>si", function() vim.lsp.buf.code_action({ filter = function(action)
		return action and action.title and action.title:lower():match("disable")
	end, apply = true }) end, desc = "ESLint: Disable rule for this line (if available)" },

	-- nvimtree 
	{ "<leader>,", telescope_builtin.buffers, desc = "Search Buffers" },
	{ "<leader>f", group = "Find" },
	{ "<leader>fb", telescope_builtin.buffers, desc = "Buffers" },
	{ "<leader>ff", telescope_builtin.find_files, desc = "File" },
	{ "<leader>fg", telescope_builtin.live_grep, desc = "Live Grep" },
	{ "<leader>fh", telescope_builtin.help_tags, desc = "Help Tags" },

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

