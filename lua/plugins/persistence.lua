local config = function()
	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>pc"] = {
			":lua require('persistence').load()<CR>",
			"Restore last session for cwd",
		},
		["<leader>pl"] = {
			":lua require('persistence').load({ last = true })<CCR>",
			"Restore last session",
		},
		["<leader>pq"] = { ":lua require('persistence').stop()<CR>", "Stop without saving session" },
	})
end

return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = {},
	config = config,
}
