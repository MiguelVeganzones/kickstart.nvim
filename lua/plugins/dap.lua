return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"Weissle/persistent-breakpoints.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()
		require("nvim-dap-virtual-text").setup({
			enabled = true,
			commented = true,
			highlight_changed_variables = true,
			show_stop_reason = true,
		})
		require("persistent-breakpoints").setup({
			load_breakpoints_event = { "BufReadPost" },
		})

		dap.adapters.gdb = {
			type = "executable",
			command = "gdb",
			args = { "-i", "dap" },
		}
		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "gdb",
				request = "launch",
				program = function()
					--return vim.fn.input('Path to executable: ', vim.cmd ':f' .. '/', 'file')
					vim.cmd(":wa")
					vim.cmd(":! make " .. vim.fn.expand("%:t:r"))
					return vim.fn.expand("%:p:h") .. "/bin/debug/" .. vim.fn.expand("%:t:r") .. ".o"
				end,
				cwd = "${workspaceFolder}",
				stopAtBeginningOfMainSubprogram = true,
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					return "/usr/bin/python"
				end,
			},
		}
		-- nvim-dap keymaps
		vim.keymap.set("n", "<leader>dk", function()
			dap.disconnect({ terminateDebuggee = true })
		end)
		vim.keymap.set("n", "<F5>", dap.continue)
		vim.keymap.set("n", "<F7>", dap.restart)
		vim.keymap.set("n", "<F10>", dap.step_over)
		vim.keymap.set("n", "<F11>", dap.step_into)
		vim.keymap.set("n", "<F12>", dap.step_out)
		vim.keymap.set("n", "<leader>rc", dap.run_to_cursor)
		vim.keymap.set("n", "<leader>b", require("persistent-breakpoints.api").toggle_breakpoint)
		vim.keymap.set("n", "<leader>cb", require("persistent-breakpoints.api").set_conditional_breakpoint)
		vim.keymap.set("n", "<leader>rb", require("persistent-breakpoints.api").clear_all_breakpoints)
		vim.keymap.set("n", "<leader>lp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end)
		vim.keymap.set("n", "<leader>?", function()
			dapui.eval(nil, { enter = true })
		end)
		vim.keymap.set("n", "<leader>dr", dap.repl.open)
		vim.keymap.set("n", "<leader>dl", dap.run_last)

		dap.listeners.before.attach.dapui_config = dapui.open
		dap.listeners.before.launch.dapui_config = dapui.open
		dap.listeners.before.event_terminated.dapui_config = dapui.close
		dap.listeners.before.event_exited.dapui_config = dapui.close
	end,
}
