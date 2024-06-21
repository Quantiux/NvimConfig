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

	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>pc"] = {
			":lua require('persistence').load()<CR>",
			"Restore last session for cwd",
		},
		["<leader>pl"] = {
			":lua require('persistence').load({ last = true })<CR>",
			"Restore last session",
		},
		["<leader>pq"] = { ":lua require('persistence').stop()<CR>", "Stop without saving session" },
	})
end

return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	config = config,
}
