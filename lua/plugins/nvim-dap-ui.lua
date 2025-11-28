return {
	'rcarriga/nvim-dap-ui',
	event = 'VeryLazy',
	dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
	config = function() 
		local dap = require('dap')
		local dapui = require('dapui')
		require('dapui').setup()

		dap.listeners.after.event_initialized['dapui_config'] = function() 
			dapui.open()
			-- Set up buffer-local keymaps for easier debugging
			vim.keymap.set('n', 'r', function() dap.continue() end, { buffer = true, desc = 'Continue' })
			vim.keymap.set('n', 'i', function() dap.step_into() end, { buffer = true, desc = 'Step Into' })
			vim.keymap.set('n', 'O', function() dap.step_out() end, { buffer = true, desc = 'Step Out' })
			vim.keymap.set('n', 'o', function() dap.step_over() end, { buffer = true, desc = 'Step Over' })
			vim.keymap.set('n', 'b', function() dap.toggle_breakpoint() end, { buffer = true, desc = 'Toggle Breakpoint' })
		end

		dap.listeners.before.event_terminated['dapui_config'] = function() 
			dapui.close()
		end

		dap.listeners.before.event_exited['dapui_config'] = function() 
			dapui.close()
		end
	end
}

