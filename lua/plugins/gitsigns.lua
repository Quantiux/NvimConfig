local config = function()
	require("gitsigns").setup()

	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>gj"] = {
			":lua require 'gitsigns'.next_hunk({navigation_message = false})<CR>",
			"Next Hunk",
		},
		["<leader>gk"] = {
			":lua require 'gitsigns'.prev_hunk({navigation_message = false})<CR>",
			"Prev Hunk",
		},
		["<leader>gp"] = { ":lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
		["<leader>gr"] = { ":lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
		["<leader>gl"] = { ":lua require 'gitsigns'.blame_line()<CR>", "Blame" },
		["<leader>gR"] = { ":lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
		["<leader>gs"] = { ":lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
		["<leader>gu"] = { ":lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk" },
		["<leader>gd"] = { ":Gitsigns diffthis HEAD<CR>", "Git Diff" },
	})
end

return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = config,
}
