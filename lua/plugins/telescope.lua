local icons = require("util.icons") -- attach icons from util/icons.lua

-- disable binary preview (https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes)
---------------------------------------------------------------------------------------
-- install telescope first by commenting (absolute)line#8-27 and line#80,
-- to avoid "telescope.previewers" not found error in line#8
---------------------------------------------------------------------------------------
local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" or filepath:match("%.json$") then
				-- if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
				-- Preserve file type for syntax highlighting (ChatGPT)
				vim.schedule(function()
					local filetype = vim.filetype.match({ filename = filepath, buf = bufnr })
					vim.api.nvim_set_option_value("filetype", filetype, { buf = bufnr })
				end)
			else
				-- maybe we want to write something to the buffer here
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(
						bufnr,
						0,
						-1,
						false,
						{ "*** Preview disabled for binary file ***" }
					)
				end)
			end
		end,
	}):sync()
end

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

	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>ff"] = { ":Telescope find_files<CR>", "Find files here" },
		["<leader>fb"] = { ":Telescope buffers<CR>", "Buffers" },
		["<leader>fr"] = { ":Telescope oldfiles<CR>", "Recent File" },
		["<leader>fl"] = { ":Telescope glyph<CR>", "Glyphs" },
		["<leader>fs"] = { ":Telescope live_grep<CR>", "Search text here" },
		-- ["<leader>fh"] = { ":Telescope find_files cwd=~<CR>", "Find files in ~" },
		-- ["<leader>fp"] = { ":Telescope find_files cwd=~/Projects<CR>", "Find files in ~/Projects" },
		-- ["<leader>fd"] = {
		-- 	":Telescope find_files cwd=~/Documents<CR>",
		-- 	"Find files in ~/Documents",
		-- },
		-- ["<leader>fR"] = { ":Telescope registers<CR>", "Registers" },
		-- ["<leader>fk"] = { ":Telescope keymaps<CR>", "Keymaps" },
		-- ["<leader>fc"] = { ":Telescope commands<CR>", "Commands" },

		-- ["<leader>sh"] = { ":Telescope live_grep cwd=~<CR>", "Search text in ~" },
		-- ["<leader>sp"] = { ":Telescope live_grep cwd=~/Projects<CR>", "Search text in ~/Projects" },
		-- ["<leader>sd"] = {
		-- 	":Telescope live_grep cwd=~/Documents<CR>",
		-- 	"Search text in ~/Documents",
		-- },
		-- ["<leader>ss"] = { ":Telescope grep_string<CR>", "Search string here" },

		["<leader>go"] = { ":Telescope git_status<CR>", "Open changed file" },
		["<leader>gb"] = { ":Telescope git_branches<CR>", "Checkout branch" },
		["<leader>gc"] = { ":Telescope git_commits<CR>", "Checkout commit" },

		["<leader>dd"] = { ":Telescope diagnostics bufnr=0<CR>", "Document Diagnostics" },
		["<leader>dw"] = { ":Telescope diagnostics<CR>", "Workspace Diagnostics" },
		["<leader>ds"] = { ":Telescope lsp_document_symbols<CR>", "Document Symbols" },
		["<leader>dS"] = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
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
