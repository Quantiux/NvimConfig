local config = function()
	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>gg"] = { ":LazyGitCurrentFile<CR>", "Open Lazygit" },
	})
end

return {
	"kdheepak/lazygit.nvim",
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = config,
}
