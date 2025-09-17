return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		log_level = "DEBUG",
		strategies = {
			inline = {},
			chat = {
				variables={
					["buffer"] = {
						opts = {
							default_params = "pin"
						}
					}
				},
				tools = {
					opts = {
						default_tools = {
							-- "files",
							-- "read_file",
							-- "cmd_runner",
							-- "search_web",
							-- "file_search",
							-- "create_file",
							-- "grep_search",
							-- "fetch_webpage",
							"full_stack_dev",
							-- "list_code_usages",
							-- "get_changed_files",
							-- "next_edit_suggestion",
							-- "insert_edit_into_file"
						},
					},
				},
			},
		},
	},
}
