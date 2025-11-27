return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")

		-- Path to mason package
		local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
		local debug_server = mason_path .. "/js-debug/src/dapDebugServer.js"

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { debug_server, "${port}" },
			},
		}

		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeExecutable = "node",
				},
				{
					type = 'pwa-node',
					request = 'attach',
					processId = function()
						return require('dap.utils').pick_process({ filter = "node" })
					end,
					name = 'Attach debugger to existing node process',
					sourceMaps = true,
					cwd = '${workspaceFolder}',
					resolveSourceMapLocations = {
						'${workspaceFolder}/**',
						'!**/node_modules/**',
					},
					outFiles = {
						'${workspaceFolder}/**',
						'!**/node_modules/**',
					},
					skipFiles = { '**/node_modules/**' },
				},
			}
		end
	end,
}
