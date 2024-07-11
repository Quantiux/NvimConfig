local config = function()
	local which_key = require("which-key")
	local close_inactive_buffers = require("util.closeInactiveBuffers")
	which_key.setup({
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			},
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = false,
				nav = false,
				z = false,
				g = false,
			},
		},
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
		},
		window = {
			border = "rounded",
			position = "bottom",
			margin = { 0, 0, 0, 0 }, -- { top, right, bottom, left }
			padding = { 1, 1, 0, 1 }, -- { top, right, bottom, left }
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = true,
		show_help = false,
		show_keys = false,
	})

	local mappings = {
		["a"] = { ":Alpha<CR>", "Dashboard" },
		["e"] = { ":NvimTreeToggle<CR>", "Explorer" },
		["w"] = { ":w!<CR>", "Save" },
		["x"] = { ":x!<CR>", "Save & quit" },
		["q"] = { ":q!<CR>", "Quit without saving" },
		["c"] = { ":bdelete<CR>", "Close buffer" },
		["h"] = { ":nohlsearch<CR>", "Disable highlight" },
		["r"] = { ":RunCode<CR>", "Run code" },
		["v"] = { ":lua require('swenv.api').pick_venv()<CR>", "Choose python env" },
		["m"] = { ":messages<CR>", "Show all messages" },
		["M"] = { ":lua vim.api.nvim_command('map')<CR>", "Show all keymaps" },
		-- sourcing doesn't work for modular config, only sources init.lua
		-- (https://www.reddit.com/r/neovim/comments/svm0gc/comment/hxhf6qb/)
		-- ["S"] = { ":luafile $MYVIMRC<CR>", "Source config" },

		d = { name = "Debug" }, -- mappings set in dap.lua
		f = { name = "Find files" }, -- mappings set in telescope.lua
		s = { name = "Search text" }, -- mappings set in telescope.lua
		g = { name = "Git" }, -- mappings set in telescope.lua, gitsigns.lua, lazygit.lua
		l = { name = "LSP/Diagnostics" }, -- mappings set in lspconfig.lua, telescope.lua
		o = { name = "Obsidian" }, -- mappings set in obsidian.lua
		p = { name = "Persistence" }, -- mappings set in persistence.lua
		C = { name = "ChatGPT" }, -- mappings set in chatgpt.lua

		b = {
			name = "Buffer navigation",
			n = { ":bnext<CR>", "Go to next buffer" },
			p = { ":bprev<CR>", "Go to previous buffer" },
			b = { ":e #<CR>", "Go to other buffer" },
			c = { close_inactive_buffers, "Close all inactive buffers" },
		},

		z = {
			name = "Split window",
			v = { ":vsplit<CR>", "Vertical split" },
			h = { ":split<CR>", "Horizontal split" },
			c = { ":q<CR>", "Close split" },
		},
	}

	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	which_key.register(mappings, opts)
end

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	config = config,
}
