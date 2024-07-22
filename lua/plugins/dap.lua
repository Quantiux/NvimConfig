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
		["<leader>Dt"] = { ":lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
		["<leader>Ds"] = { ":lua require'dap'.continue()<CR>", "Start" },
		["<leader>Dc"] = { ":lua require'dap'.continue()<CR>", "Continue" },
		["<leader>Db"] = { ":lua require'dap'.step_back()<CR>", "Step Back" },
		["<leader>DC"] = { ":lua require'dap'.run_to_cursor()<CR>", "Run To Cursor" },
		["<leader>Dd"] = { ":lua require'dap'.disconnect()<CR>", "Disconnect" },
		["<leader>Dg"] = { ":lua require'dap'.session()<CR>", "Get Session" },
		["<leader>Di"] = { ":lua require'dap'.step_into()<CR>", "Step Into" },
		["<leader>Do"] = { ":lua require'dap'.step_over()<CR>", "Step Over" },
		["<leader>Du"] = { ":lua require'dap'.step_out()<CR>", "Step Out" },
		["<leader>Dp"] = { ":lua require'dap'.pause()<CR>", "Pause" },
		["<leader>Dr"] = { ":lua require'dap'.repl.toggle()<CR>", "Toggle Repl" },
		["<leader>Dq"] = { ":lua require'dap'.close()<CR>", "Quit" },
		["<leader>DU"] = { ":lua require'dapui'.toggle({reset = true})<CR>", "Toggle UI" },
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
