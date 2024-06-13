local config = function()
	local dap = require("dap")
	local dap_python = require("dap-python")
	local dap_ui = require("dapui")

	-- dap-python setup
	-- install debuggy via mason, attach path to dap-python
	local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
	dap_python.setup(path)

	-- dap-ui setup
	-- use nvim-dap to auto-open/close ui windows
	dap.listeners.before.attach.dapui_config = function()
		dap_ui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dap_ui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dap_ui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dap_ui.close()
	end

	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>dt"] = { ":lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
		["<leader>ds"] = { ":lua require'dap'.continue()<CR>", "Start" },
		["<leader>dc"] = { ":lua require'dap'.continue()<CR>", "Continue" },
		["<leader>db"] = { ":lua require'dap'.step_back()<CR>", "Step Back" },
		["<leader>dC"] = { ":lua require'dap'.run_to_cursor()<CR>", "Run To Cursor" },
		["<leader>dd"] = { ":lua require'dap'.disconnect()<CR>", "Disconnect" },
		["<leader>dg"] = { ":lua require'dap'.session()<CR>", "Get Session" },
		["<leader>di"] = { ":lua require'dap'.step_into()<CR>", "Step Into" },
		["<leader>do"] = { ":lua require'dap'.step_over()<CR>", "Step Over" },
		["<leader>du"] = { ":lua require'dap'.step_out()<CR>", "Step Out" },
		["<leader>dp"] = { ":lua require'dap'.pause()<CR>", "Pause" },
		["<leader>dr"] = { ":lua require'dap'.repl.toggle()<CR>", "Toggle Repl" },
		["<leader>dq"] = { ":lua require'dap'.close()<CR>", "Quit" },
		["<leader>dU"] = { ":lua require'dapui'.toggle({reset = true})<CR>", "Toggle UI" },
	})
end

return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
		},
	},
	config = config,
}
