-- Toggle a "zoom" of the current window into its own tab, preserving the
-- original split layout so it can be restored later (like tmux's <leader>z).

local M = {}

local zoomed = false

function M.toggle()
	if zoomed then
		vim.cmd("tabclose")
		zoomed = false
	else
		vim.cmd("tab split")
		zoomed = true
	end
end

return M
