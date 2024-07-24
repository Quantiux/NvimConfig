local config = function()
	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment (normal)" },
	}, { mode = "n" }) -- normal mode mapping
	wk.register({
		["<leader>/"] = { "<Plug>(comment_toggle_linewise_visual)", "Toggle comment (visual)" },
	}, { mode = "v" }) -- visual mode mapping
end

return {
	"numToStr/Comment.nvim",
	config = config,
	lazy = false,
}
