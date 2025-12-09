local M = {}

function M.save()
	local session_name = vim.fn.input('Enter session name: ')
	if session_name and #session_name > 0 then
		vim.cmd("AutoSession save " .. session_name)
	else
		print('Session name cannot be empty!')
	end
end

return M
