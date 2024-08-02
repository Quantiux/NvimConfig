local config = function()
	vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
	vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
	-- Create a table with the options to be passed to setup()
	local opts = {
		R_args = { "--quiet", "--no-save" },
		min_editor_width = 72,
		rconsole_width = 78,
		disable_cmds = {
			"RClearConsole",
			"RCustomStart",
			"RSPlot",
			"RSaveClose",
		},
	}
	-- make sure alias r is set to "R_AUTO_START=true nvim"
	if vim.env.R_AUTO_START == "true" then
		opts.auto_start = 1
		opts.objbr_auto_start = true
	end
	require("r").setup(opts)
end

return {
	"R-nvim/R.nvim",
	lazy = false, -- if lazy.nvim set to lazy = true (default)
	config = config,
	dependencies = {
		"R-nvim/cmp-r", -- also a dependency in nvim-cmp
		"nvim-treesitter/nvim-treesitter",
	},
}
