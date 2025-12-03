-- Helper functions for operating system detection

local M = {}

--- Detect the current operating system
--- @return string "linux" | "wsl" | "windows" | "macos" | "unknown"
function M.detect_os()
	local system_info = vim.uv.os_uname()
	local system_name = system_info.sysname
	local release = system_info.release

	if system_name == "Linux" then
		if release:find("microsoft") and release:find("WSL") then
			return "wsl"
		else
			return "linux"
		end
	elseif system_name == "Windows_NT" then
		return "windows"
	elseif system_name == "Darwin" then
		return "macos"
	else
		return "unknown"
	end
end

return M
