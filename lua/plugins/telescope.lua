local icons = require("util.icons") -- attach icons from util/icons.lua

-- disable binary preview (https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes)
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			else
				-- maybe we want to write something to the buffer here
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
				end)
			end
		end,
	}):sync()
end

local config = function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	telescope.setup({
		defaults = {
			prompt_prefix = icons.ui.Telescope .. " ",
			selection_caret = icons.ui.Forward .. " ",
			path_display = { "smart" },
			entry_prefix = "   ",
			initial_mode = "insert",
			selection_strategy = "reset",
			color_devicons = true,
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
			},
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<esc>"] = actions.close, -- quit on <ESC>
				},
			},
			preview = {
				filesize_limit = 0.1, -- MB
			},
			buffer_previewer_maker = new_maker,
		},
		pickers = {
			find_files = {
				-- theme = "dropdown",
				previewer = true,
				hidden = true,
				find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
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
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			},
		},
	})

	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>ff"] = { ":Telescope find_files<CR>", "Find files here" },
		["<leader>fh"] = { ":Telescope find_files cwd=~<CR>", "Find files in ~" },
		["<leader>fp"] = { ":Telescope find_files cwd=~/Projects<CR>", "Find files in ~/Projects" },
		["<leader>fd"] = {
			":Telescope find_files cwd=~/Documents<CR>",
			"Find files in ~/Documents",
		},
		["<leader>fb"] = { ":Telescope buffers<CR>", "Buffers" },
		["<leader>fr"] = { ":Telescope oldfiles<CR>", "Recent File" },
		["<leader>fg"] = { ":Telescope git_branches<CR>", "Checkout branch" },
		["<leader>fR"] = { ":Telescope registers<CR>", "Registers" },
		["<leader>fk"] = { ":Telescope keymaps<CR>", "Keymaps" },
		["<leader>fc"] = { ":Telescope commands<CR>", "Commands" },

		["<leader>sf"] = { ":Telescope live_grep<CR>", "Search text here" },
		["<leader>sh"] = { ":Telescope live_grep cwd=~<CR>", "Search text in ~" },
		["<leader>sp"] = { ":Telescope live_grep cwd=~/Projects<CR>", "Search text in ~/Projects" },
		["<leader>sd"] = {
			":Telescope live_grep cwd=~/Documents<CR>",
			"Search text in ~/Documents",
		},
		["<leader>ss"] = { ":Telescope grep_string<CR>", "Search string here" },

		["<leader>go"] = { ":Telescope git_status<CR>", "Open changed file" },
		["<leader>gb"] = { ":Telescope git_branches<CR>", "Checkout branch" },
		["<leader>gc"] = { ":Telescope git_commits<CR>", "Checkout commit" },

		["<leader>ld"] = { ":Telescope diagnostics bufnr=0<CR>", "Document Diagnostics" },
		["<leader>lw"] = { ":Telescope diagnostics<CR>", "Workspace Diagnostics" },
		["<leader>ls"] = { ":Telescope lsp_document_symbols<CR>", "Document Symbols" },
		["<leader>lS"] = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
	})

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
