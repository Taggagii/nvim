local M = {}

function M.format_file()
	local status, error = pcall(function()
		vim.cmd("LspEslintFixAll")
	end)

	if not status then
		vim.notify('LspEslintFixAll failed: ' .. tostring(err) .. '. Using vim.lsp.buf.format() instead.', vim.log.levels.WARN)
		vim.lsp.buf.format()
	end
end

return M
