local config = function()
	require("persistence").setup({
		dir = vim.fn.stdpath("state") .. "/sessions/", -- ~/.local/state/nvim/sessions
		options = { "buffers", "curdir", "tabpages", "winsize" }, -- options for `:mksession`
		pre_save = nil, -- a function to call before saving the session
		post_save = nil, -- a function to call after saving the session
		save_empty = false, -- don't save if there are no open file buffers
		pre_load = nil, -- a function to call before loading the session
		post_load = nil, -- a function to call after loading the session
	})
end

return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	config = config,
}
