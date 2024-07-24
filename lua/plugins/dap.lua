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
