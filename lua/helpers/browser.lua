-- Helper functions for opening URLs in the browser

local os_helper = require('helpers.os')

local M = {}

--- Open a URL in the default browser based on the operating system
--- @param url string The URL to open
function M.open_url(url)
	local os_type = os_helper.detect_os()

	if os_type == "wsl" then
		vim.system({"wslview", url})
	elseif os_type == "linux" then
		vim.system({"xdg-open", url})
	elseif os_type == "windows" then
		vim.system({"cmd", "/c", "start", url})
	elseif os_type == "macos" then
		vim.system({"open", url})
	else
		print("Unable to open URL: Unknown operating system")
	end
end

return M
