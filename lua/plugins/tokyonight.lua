local config = function()
	local tokyonight = require("tokyonight")
	tokyonight.setup({
		style = "storm",
		transparent = false,
		terminal_colors = false,
		hide_inactive_statusline = false,
		styles = {
			comments = { italic = true },
			keywords = { italic = false },
		},
		on_colors = function(colors)
			colors.comment = "#7e86b9" -- brighten up comments
		end,
	})
	vim.cmd("colorscheme tokyonight")
end

return {
	"folke/tokyonight.nvim",
	lazy = false, -- do NOT lazy load (ALWAYS load color scheme)
	priority = 1000, -- high priority so it loads before everything else
	config = config,
}
