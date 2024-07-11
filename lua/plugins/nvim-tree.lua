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
	-- parameters for floating window size and position
	-- (https://github.com/MarioCarrion/videos/blob/269956e913b76e6bb4ed790e4b5d25255cb1db4f/2023/01/nvim/lua/plugins/nvim-tree.lua)
	local WIDTH_RATIO = 0.5
	local HEIGHT_RATIO = 0.9
	local screen_w = vim.opt.columns:get()
	local lines = vim.opt.lines:get()
	local cmdheight = vim.opt.cmdheight:get()
	local screen_h = lines - cmdheight
	local window_w = screen_w * WIDTH_RATIO
	local window_h = screen_h * HEIGHT_RATIO
	local window_w_int = math.floor(window_w)
	local window_h_int = math.floor(window_h)
	local center_x = (screen_w - window_w) / 2
	local center_y = ((lines - window_h) / 2) - cmdheight

	require("nvim-tree").setup({
		on_attach = my_on_attach,
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		view = {
			centralize_selection = true,
			width = window_w_int,
			relativenumber = true, -- <#>j to move down, <#>k to move up
			float = {
				enable = true,
				quit_on_focus_loss = true,
				open_win_config = function()
					return {
						relative = "editor",
						border = "rounded",
						width = window_w_int,
						height = window_h_int,
						row = center_y,
						col = center_x,
					}
				end,
			},
			-- side = "right",
			-- width = 30,
			-- adaptive_size = true,
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
