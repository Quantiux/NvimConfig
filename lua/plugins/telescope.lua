local icons = require("util.icons") -- attach icons from util/icons.lua

local config = function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	telescope.setup({
		defaults = {
			prompt_prefix = icons.ui.Telescope .. " ",
			selection_caret = icons.ui.Forward .. " ",
			path_display = { "smart" },
			entry_prefix = "   ",
			initial_mode = "insert",
			selection_strategy = "reset",
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
				"--glob=!.git/", -- exclude .git directory from searches
				"--glob=!node_modules/", -- exclude node_modules directories
				"--glob=!virtualenvs/", -- exclude virtualenvs directories
				"--glob=!virtualenv/", -- exclude virtualenv directories
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

				-- open buffer on right split (normal mode)
				n = {
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
		},
		pickers = {
			find_files = {
				-- theme = "dropdown",
				find_command = {
					"rg",
					"--files", -- list only files, not content within
					"--hidden", -- include hidden files
					"--glob=!.git/", -- exclude .git directories
					"--glob=!node_modules/", -- exclude node_modules directories
					"--glob=!virtualenvs/", -- exclude virtualenvs directories
					"--glob=!virtualenv/", -- exclude virtualenv directories
				},
				previewer = true,
				layout_config = {
					width = 0.87,
					height = 0.9,
				},
			},
			live_grep = {
				-- theme = "dropdown",
				previewer = true,
				layout_config = {
					width = 0.87,
					height = 0.9,
				},
			},
			buffers = {
				-- theme = "dropdown",
				previewer = true,
				layout_config = {
					width = 0.87,
					height = 0.9,
				},
			},
		},
		-- these are extension defaults
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})

	-- load extension
	telescope.load_extension("fzf")
	telescope.load_extension("glyph") -- to get font glyphs (including unicode)
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "ghassan0/telescope-glyph.nvim" },
	},
	config = config,
}
