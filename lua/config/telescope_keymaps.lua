local wk = require('which-key')
local builtin = require('telescope.builtin')

wk.add({
    { "<leader>,", builtin.buffers, desc = "Search Buffers" },
    { "<leader>f", group = "Find" },
    { "<leader>fb", builtin.buffers, desc = "Buffers" },
    { "<leader>ff", builtin.find_files, desc = "File" },
    { "<leader>fg", builtin.live_grep, desc = "Live Grep" },
    { "<leader>fh", builtin.help_tags, desc = "Help Tags" },
}, { prefix = "<leader>" })
