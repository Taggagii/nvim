local wk = require('which-key')

-- -- that alt move behaviour
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
-- vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
-- vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- -- float term stuff
-- vim.keymap.set("n", "<C-_>", ":FloatermToggle<CR>")
-- vim.keymap.set("t", "<C-_>", "<C-\\><C-n>:FloatermToggle<CR>")

wk.add({
	-- Lazy stuff
	{ "<leader>l", "<cmd>Lazy<CR>", desc = "Lazy" }, -- moved to avoid conflict with LSP group

	-- NvimTree
	{ "<leader>e", function()
		local ok, nvimtree = pcall(require, "nvim-tree.api")
		if ok and nvimtree then
			nvimtree.tree.toggle()
		else
			vim.notify("nvim-tree is not loaded", vim.log.levels.WARN)
		end
	end, desc = "Toggle Explorer" },

	-- Buffer stuff
	{ "<leader>b", group = "Buffer" },
	{ "<leader>bd", "<cmd>bd<CR>", desc = "Close current buffer" },
	{ "<leader>q", group = "Quit" },
	{ "<leader>qw", "<cmd>wq<CR>", desc = "Write and close current file" },
	{ "<leader>qq", "<cmd>q<CR>", desc = "Quit the current file without saving" },
	{ "<leader>m", group = "Mason Stuff" },
	{ "<leader>mm", "<cmd>Mason<CR>", desc = "Open Mason Configuration" },
	{ "<leader>c", group = "Code Companion Stuff" },
	-- Open CodeCompanion chat with buffer context
	{ "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle the chat open or closed", mode = { "v", "n" } },
	{ "<leader>cp", "<cmd>CodeCompanionChat Add<CR>", desc = "Add visually selected code to chat", mode = { "v" } },
	{ "<leader>ce", "<cmd>CodeCompanion /explain<CR>", desc = "Explain the selected code using Code Companion", mode = { "v" } },
	{ "<leader>ca", "<cmd>CodeCompanionAction<CR>", desc = "Run a Code Companion action on selection or line", mode = { "n", "v" } },
	{ "<leader>cf", "<cmd>CodeCompanion /fix @{insert_edit_into_file}<CR>", desc = "Fix selected code and insert edit into file", mode = { "v" }},

    -- ESLint group and actions (now under <leader>s)
    { "<leader>s", group = "ESLint" },
    { "<leader>sf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format with ESLint" },
    { "<leader>sfx", function() vim.lsp.buf.execute_command({ command = "eslint.applyAllFixes" }) end, desc = "ESLint: Fix All" },
    { "<leader>sr", function() vim.cmd('LspRestart eslint') end, desc = "Restart ESLint server" },
    { "<leader>sd", function() vim.diagnostic.open_float() end, desc = "Show ESLint diagnostics (float)" },
    { "<leader>si", function() vim.lsp.buf.code_action({ filter = function(action)
        return action and action.title and action.title:lower():match("disable")
    end, apply = true }) end, desc = "ESLint: Disable rule for this line (if available)" },
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

