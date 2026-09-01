-- AI CLI terminal integration (Copilot CLI, Claude, etc.) + Copilot LSP Next Edit Suggestions

return {
	"folke/sidekick.nvim",
	opts = {
		-- Automatic Next Edit Suggestions are off by default; toggle back on with
		-- <leader>an (see keymaps.lua).
		nes = {
			enabled = false,
		},
		-- Only Copilot CLI is in use for now, so it's the only tool registered.
		-- Once other tools are wanted again, add them back here and the keymaps'
		-- toggle()/select() calls will show a picker instead of defaulting.
		cli = {
			tools = {
				copilot = {},
			},
			win = {
				keys = {
					-- Matches better-escape.nvim's "ij" -> Escape convention: leave the
					-- terminal and go back to the previous window without closing it.
					blur_ij = { "ij", "blur", mode = "t", desc = "blur (leave to previous window)" },
				},
			},
		},
	},
	config = function(_, opts)
		require("sidekick").setup(opts)

		-- Sidekick's tmux backend scans *every* tmux session on the machine for
		-- running CLI tools and lists them as "external" picker candidates. Attaching
		-- to one it didn't create itself silently no-ops (its own attach command only
		-- matches sessions it started), so selecting them appears to do nothing.
		-- We only use Sidekick's own embedded terminal, so disable this discovery.
		local Session = require("sidekick.cli.session")
		Session.setup()
		Session.backends.tmux = nil

		-- `opts.cli.tools` above narrows the tool list, but Config.setup() merges
		-- tables rather than replacing them, so explicitly drop everything but
		-- copilot here to guarantee toggle()/select() never show a tool picker.
		require("sidekick.config").cli.tools = { copilot = {} }

		-- Sidekick reopens its terminal window at the configured default size
		-- (win.split.width/height) every time, discarding any manual resize.
		-- Remember the last size on close and restore it on reopen so <leader>aa
		-- toggling doesn't shrink the window back to the default.
		local last_width, last_height
		local group = vim.api.nvim_create_augroup("sidekick_remember_size", { clear = true })

		vim.api.nvim_create_autocmd("WinClosed", {
			group = group,
			callback = function(ev)
				local win = tonumber(ev.match)
				if not win or not vim.api.nvim_win_is_valid(win) then
					return
				end
				local buf = vim.api.nvim_win_get_buf(win)
				if vim.bo[buf].filetype == "sidekick_terminal" then
					last_width = vim.api.nvim_win_get_width(win)
					last_height = vim.api.nvim_win_get_height(win)
				end
			end,
		})

		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = group,
			callback = function(ev)
				if vim.bo[ev.buf].filetype ~= "sidekick_terminal" then
					return
				end
				local win = vim.fn.win_findbuf(ev.buf)[1]
				if not win then
					return
				end
				vim.schedule(function()
					if not vim.api.nvim_win_is_valid(win) then
						return
					end
					if last_width then
						pcall(vim.api.nvim_win_set_width, win, last_width)
					end
					if last_height then
						pcall(vim.api.nvim_win_set_height, win, last_height)
					end
				end)
			end,
		})
	end,
}
