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
		-- brighten up comments
		on_colors = function(colors)
			colors.comment = "#7e86b9"
		end,
		-- darken background color of markdown's inline codes
		on_highlights = function(highlights, colors)
			highlights["@markup.raw.markdown_inline"] = { bg = "#273746", fg = colors.blue }
			-- highlights["@markup.raw.markdown_inline"] = { bg = colors.none, fg = colors.blue }
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
