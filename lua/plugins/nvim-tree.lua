local icons = require("util.icons") -- attach icons from util/icons.lua

-- function to replace default key mappings
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return {
			desc = "nvim-tree: " .. desc,
			buffer = bufnr,
			noremap = true,
			silent = true,
			nowait = true,
		}
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- mappings to switch "d" and "D" (for trash and delete now) and "?" for help
	vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
	vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

local config = function()
	require("nvim-tree").setup({
		on_attach = my_on_attach,
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		view = {
			side = "right",
			width = 30,
			adaptive_size = true,
			relativenumber = true, -- <#>j to move down, <#>k to move up
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
			dotfiles = false,
			git_ignored = false,
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
