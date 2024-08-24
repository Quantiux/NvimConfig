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

	-- Function to open link under cursor
	local function open_link()
		local url = vim.fn.expand("<cfile>")
		if url ~= "" then
			os.execute(string.format("xdg-open %q", url))
		else
			print("No URL found under cursor")
		end
	end

	local vmappings = { -- visual mode mappings
		["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Toggle comment" },
	}

	local mappings = { -- normal mode mappings

		-- individual mappings
		["a"] = { ":Alpha<CR>", "Dashboard" },
		["e"] = { ":NvimTreeToggle<CR>", "Explorer" },
		["w"] = { ":w!<CR>", "Save" },
		["x"] = { ":x!<CR>", "Save & quit" },
		["q"] = { ":q!<CR>", "Quit without saving" },
		["c"] = { ":bdelete<CR>", "Close buffer" },
		["h"] = { ":nohlsearch<CR>", "Disable highlight" },
		["r"] = { ":RunCode<CR>", "Run code" },
		["v"] = { ":lua require('swenv.api').pick_venv()<CR>", "Choose python env" },
		["k"] = { ":lua vim.api.nvim_command('map')<CR>", "Show all keymaps" },
		["/"] = { "<Plug>(comment_toggle_linewise_current)", "Toggle comment" },
		-- ["W"] = { ":lua print('pwd = ' .. vim.fn.getcwd())<CR>", "Show pwd" },
		["Q"] = { ":QuartoPreview<CR>", "Open Quarto" },
		["L"] = { open_link, "Open link under cursor" },

		-- group mapping
		f = {
			name = "Telescope",
			f = { ":Telescope find_files<CR>", "Find files" },
			c = { ":Telescope find_files cwd=~/.config<CR>", "Find files in .config" },
			d = { ":Telescope find_files cwd=~/Documents<CR>", "Find files in Documents" },
			p = { ":Telescope find_files cwd=~/Projects<CR>", "Find files in Projects" },
			b = { ":Telescope buffers<CR>", "Buffers" },
			r = { ":Telescope oldfiles<CR>", "Recent File" },
			g = { ":Telescope live_grep<CR>", "Search text" },
			C = { ":Telescope live_grep cwd=~/.config<CR>", "Search text in .config" },
			D = { ":Telescope live_grep cwd=~/Documents<CR>", "Search text in Documents" },
			P = { ":Telescope live_grep cwd=~/Projects<CR>", "Search text in Projects" },
			i = { ":Telescope glyph<CR>", "Find icons" },
		},
		g = {
			name = "Git",
			g = { ":LazyGitCurrentFile<CR>", "Open Lazygit" },
			o = { ":Telescope git_status<CR>", "Open changed file" },
			b = { ":Telescope git_branches<CR>", "Checkout branch" },
			c = { ":Telescope git_commits<CR>", "Checkout commit" },
			j = {
				":lua require 'gitsigns'.next_hunk({navigation_message = false})<CR>",
				"Next Hunk",
			},
			k = {
				":lua require 'gitsigns'.prev_hunk({navigation_message = false})<CR>",
				"Prev Hunk",
			},
			p = { ":lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
			r = { ":lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
			l = { ":lua require 'gitsigns'.blame_line()<CR>", "Blame" },
			R = { ":lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
			s = { ":lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
			u = { ":lua require 'gitsigns'.undo_stage_hunk()<CR>", "Undo Stage Hunk" },
			d = { ":Gitsigns diffthis HEAD<CR>", "Git Diff" },
		},
		d = {
			name = "LSP/Diagnostics",
			d = { ":Telescope diagnostics bufnr=0<CR>", "Document Diagnostics" },
			w = { ":Telescope diagnostics<CR>", "Workspace Diagnostics" },
			s = { ":Telescope lsp_document_symbols<CR>", "Document Symbols" },
			S = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "Workspace Symbols" },
			i = { ":LspInfo<CR>", "Info" },
			j = { ":lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
			k = { ":lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },
			a = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
			l = { ":lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
			q = { ":lua vim.diagnostic.setloclist()<CR>", "Quickfix" },
			r = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
			f = { ":lua vim.lsp.buf.format{async=true}<CR>", "Format" },
		},
		o = {
			name = "Obsidian",
			o = { ":ObsidianOpen<CR>", "Open a note" },
			n = { ":ObsidianNew<CR>", "Create a new note" },
			f = { ":ObsidianSearch<CR>", "Find a note" },
			q = { ":ObsidianQuickSwitch<CR>", "Quickly switch note" },
			l = { ":ObsidianFollowLink<CR>", "Follow link under cursor" },
			b = { ":ObsidianBacklinks<CR>", "Get links list to buffer" },
			m = { ":ObsidianLink<CR>", "Link selected text to note" },
			p = { ":ObsidianLinkNew<CR>", "Create a note with link text" },
			t = { ":ObsidianTemplate<CR>", "Insert template" },
			T = { ":ObsidianTags<CR>", "Get reference list for tag" },
			r = { ":ObsidianPasteImg<CR>", "Paste image from vault" },
			x = { ":ObsidianToggleCheckbox<CR>", "Cycle through checkbox options" },
		},
		p = {
			name = "Persistence",
			c = {
				":lua require('persistence').load()<CR>",
				"Restore last session for cwd",
			},
			l = {
				":lua require('persistence').load({ last = true })<CR>",
				"Restore last session",
			},
			q = { ":lua require('persistence').stop()<CR>", "Stop without saving session" },
		},
		C = {
			name = "ChatGPT",
			c = { ":ChatGPT<CR>", "ChatGPT" },
			x = { ":ChatGPTRun explain_code<CR>", "Explain code", mode = { "n", "v" } },
			f = { ":ChatGPTRun fix_bugs<CR>", "Fix bugs", mode = { "n", "v" } },
			o = { ":ChatGPTRun optimize_code<CR>", "Optimize code", mode = { "n", "v" } },
			a = { ":ChatGPTRun add_tests<CR>", "Add tests", mode = { "n", "v" } },
			C = { ":ChatGPTCompleteCode<CR>", "CodeCompletion", mode = { "n", "v" } },
			e = {
				":ChatGPTEditWithInstructions<CR>",
				"Edit with instruction",
				mode = { "n", "v" },
			},
			g = {
				":ChatGPTRun grammar_correction<CR>",
				"Grammar Correction",
				mode = { "n", "v" },
			},
			t = { ":ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
			s = { ":ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
			l = {
				":ChatGPTRun code_readability_analysis<CR>",
				"Code Readability Analysis",
				mode = { "n", "v" },
			},
		},
		D = {
			name = "Debug",
			t = { ":lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
			s = { ":lua require'dap'.continue()<CR>", "Start" },
			c = { ":lua require'dap'.continue()<CR>", "Continue" },
			b = { ":lua require'dap'.step_back()<CR>", "Step Back" },
			C = { ":lua require'dap'.run_to_cursor()<CR>", "Run To Cursor" },
			d = { ":lua require'dap'.disconnect()<CR>", "Disconnect" },
			g = { ":lua require'dap'.session()<CR>", "Get Session" },
			i = { ":lua require'dap'.step_into()<CR>", "Step Into" },
			o = { ":lua require'dap'.step_over()<CR>", "Step Over" },
			u = { ":lua require'dap'.step_out()<CR>", "Step Out" },
			p = { ":lua require'dap'.pause()<CR>", "Pause" },
			r = { ":lua require'dap'.repl.toggle()<CR>", "Toggle Repl" },
			q = { ":lua require'dap'.close()<CR>", "Quit" },
			U = { ":lua require'dapui'.toggle({reset = true})<CR>", "Toggle UI" },
		},
		b = {
			name = "Buffer navigation",
			n = { ":bnext<CR>", "Go to next buffer" },
			p = { ":bprev<CR>", "Go to previous buffer" },
			b = { ":e #<CR>", "Go to other buffer" },
			c = { close_inactive_buffers, "Close all inactive buffers" },
		},
		l = {
			name = "Lazy",
			l = { ":Lazy<CR>", ":Lazy" },
			c = { ":Lazy check<CR>", "Check for plugin updates" },
			x = { ":Lazy clean<CR>", "Remove unused plugins" },
			i = { ":Lazy install<CR>", "Install missing plugins" },
			r = { ":Lazy restore<CR>", "Restore/sync plugins to lock file" },
			u = { ":Lazy update<CR>", "Update plugins (including lock file)" },
		},
		n = {
			name = "Noice",
			d = { ":Noice dismiss<CR>", "Dismiss all visible messages" },
			t = { ":Noice telescope<CR>", "Show messages in Telescope" },
			l = { ":Noice last<CR>", "Show last message" },
			e = { ":Noice errors<CR>", "Show error messages (last on top)" },
		},
		z = {
			name = "Split window",
			v = { ":vsplit<CR>", "Vertical split" },
			h = { ":split<CR>", "Horizontal split" },
			c = { ":q<CR>", "Close split" },
		},
		W = {
			name = "Spell check",
			a = { "zg", "Add to dictionary" },
			r = { "zug", "Remove from dictionary" },
		},
	}

	local vopts = {
		mode = "v", -- VISUAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
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
	which_key.register(vmappings, vopts)
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
