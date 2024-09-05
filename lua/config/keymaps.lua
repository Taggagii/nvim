local wk = require('which-key')

-- that alt move behaviour
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- floating terminal
vim.keymap.set("n", "<C-_>", ":FloatermToggle<CR>")
vim.keymap.set("t", "<C-_>", "<C-\\><C-n>:FloatermToggle<CR>")

wk.register({
	-- e = { vim.cmd.Ex, "Explorer" },
	l = { ":Lazy<CR>", "Lazy" },
	b = {
		name = "Buffer",
		d = { ":bd<CR>", "Close current buffer" },
	},
	q = {
		name = "Quit",
		w = { ":wq<CR>", "Write and close current file"},
		q = { ":q<CR>", "Quit the current file without saving"},
	}
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

