-- reload buffers automatically when the underlying file changes on disk,
-- as long as the buffer has no unsaved changes (mirrors VS Code's behavior)
vim.opt.autoread = true

local group = vim.api.nvim_create_augroup("AutoReload", { clear = true })

-- these events are when Neovim actually checks the filesystem for changes
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = group,
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- CursorHold only fires after 'updatetime' (ms) of no input, so poll on a
-- timer too, letting a file update while you're idle in insert/normal mode
-- without touching the cursor.
local timer = vim.uv.new_timer()
timer:start(1000, 1000, vim.schedule_wrap(function()
  if vim.fn.mode() ~= "c" then
    vim.cmd("checktime")
  end
end))

-- notify when a file was changed and reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = group,
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk, buffer reloaded", vim.log.levels.INFO)
  end,
})
