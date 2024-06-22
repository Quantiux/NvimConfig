local icons = require("util.icons") -- attach icons from util/icons.lua

local config = function()
	require("nvim-tree").setup({
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		view = {
			side = "right",
			width = 30,
			adaptive_size = true,
			relativenumber = true,  -- <#>j to move down, <#>k to move up
		},
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			icons = {
				error = icons.diagnostics.Error,
				warning = icons.diagnostics.Warn,
				hint = icons.diagnostics.Hint,
				info = icons.diagnostics.Info,
			},
		},
		filters = {
			enable = true,
			git_ignored = false,
			dotfiles = false,
			exclude = {},
		},
		update_focused_file = {
			enable = true,
			update_root = {
				enable = false,
				ignore_list = {},
			},
		},
	})
end

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false, -- load as soon as Neovim opens
	config = config,
}

-- install "nvim-web-devicons" plugin to display icons by file type
