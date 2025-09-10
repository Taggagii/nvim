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
    { "<leader>l", "<cmd>Lazy<CR>", desc = "Lazy" },
    { "<leader>b", group = "Buffer" },
    { "<leader>bd", "<cmd>bd<CR>", desc = "Close current buffer" },
    { "<leader>q", group = "Quit" },
    { "<leader>qw", "<cmd>wq<CR>", desc = "Write and close current file" },
    { "<leader>qq", "<cmd>q<CR>", desc = "Quit the current file without saving" },
    { "<leader>m", group = "Mason Stuff" },
    { "<leader>mm", "<cmd>Mason<CR>", desc = "Open Mason Configuration" },
    { "<leader>c", group = "Code Companion Stuff" },
	{ "<leader>cc", "<cmd>CodeCompanionChat<CR>", desc = "Open Chat" },
	{ "<leader>ca", "<cmd>CodeCompanionChat Add<CR>", desc = "Add some code to the chat" },
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

-- This function prompts for input and runs :'<,'>CodeCompanion {input} on the current visual selection
function CodeCompanionPrompt()
  -- Save current visual selection marks
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  vim.ui.input({
    prompt = 'CodeCompanion command:',
    default = '',
  }, function(input)
    if input and input ~= '' then
      -- Reselect the visual selection
      vim.fn.setpos("'<", start_pos)
      vim.fn.setpos("'>", end_pos)
      -- Run the command on the selection
      vim.cmd("'<,'>CodeCompanion " .. input)
    end
  end)
end

-- Map to <leader>cc in visual mode (you can change this mapping)
vim.keymap.set('v', '<leader>cc', function()
  CodeCompanionPrompt()
end, { noremap = true, silent = true, desc = 'CodeCompanion prompt on selection' })

