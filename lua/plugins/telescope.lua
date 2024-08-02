local icons = require("util.icons") -- attach icons from util/icons.lua
local binary_disabled_maker = require("util.disableBinaryPreview")

local config = function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	telescope.setup({
		defaults = {
			layout_config = {
				width = 0.85,
				height = 0.9,
				preview_width = 0.55,
				prompt_position = "top",
			},
			prompt_prefix = icons.ui.Telescope .. " ",
			selection_caret = icons.ui.Forward .. " ",
			path_display = { "truncate" }, -- show as much path as fits
			entry_prefix = "   ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending", -- top-down
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" },
			-- vimgrep_arguments{} are used by live_grep and grep_string pickers
			vimgrep_arguments = {
				"rg", -- use ripgrep
				"--color=never", -- disable color in output for better pasring
				"--no-heading", -- no file headers in output
				"--with-filename", -- show filename in output
				"--line-number", -- show line number in output
				"--column", -- show column number in output
				"--smart-case", -- smart case for case-sensitive searches
				"--hidden", -- include hidden files
			},
			mappings = {
				-- insert mode actions
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<esc>"] = actions.close, -- quit on <ESC>

					-- open buffer on right split
					["<C-v>"] = function(prompt_bufnr)
						local selected_entry = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						vim.cmd("vsplit")
						vim.cmd("edit " .. selected_entry.value)
					end,
				},

				n = {
					-- open buffer on right split (normal mode)
					["<C-v>"] = function(prompt_bufnr)
						local selected_entry = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						vim.cmd("vsplit")
						vim.cmd("edit " .. selected_entry.value)
					end,
				},
			},
			preview = {
				filesize_limit = 0.1, -- MB
				highlight_limit = 0.1, -- MB
				timeout = 200, -- ms
				treesitter = true, -- treesitter highlighting
			},
			buffer_previewer_maker = binary_disabled_maker,
		},
		pickers = {
			find_files = {
				find_command = {
					"rg",
					"--files", -- list only files, not content within
					"--hidden", -- include hidden files
				},
				previewer = true,
			},
			live_grep = {
				previewer = true,
			},
			buffers = {
				previewer = true,
			},
		},
		-- these are extension defaults
		extensions = {
			fzf = {
				fuzzy = true, -- false will do exact matching
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})

	-- load extension
	telescope.load_extension("fzf")
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = config,
}
