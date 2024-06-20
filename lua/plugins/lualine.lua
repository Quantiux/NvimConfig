local icons = require("util.icons") -- attach util/icons.lua
local lsp_clients = require("util.lspclients") -- attach util/lspclients.lua
local get_venv = require("util.pyenv") -- attach util/pyenv.lua

-- get python environment
local venv = {
	get_venv,
	color = { fg = "#ffc777" },
	-- color = { fg = "#e3e3e3" },
}

-- local venv = {
-- 	"swenv",
-- 	icons_enabled = true,
-- 	icon = "󰌠",
-- 	-- color = { fg = "#61afef" },
-- }

-- get LSP clients attached to current buffer
local lsp = {
	lsp_clients,
	color = { fg = "#e3e3e3" },
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "hint", "info" },
	symbols = {
		error = icons.diagnostics.Error,
		warn = icons.diagnostics.Warn,
		hint = icons.diagnostics.Hint,
		info = icons.diagnostics.Info,
	},
	colored = true,
	update_in_insert = false,
	always_visible = false,
}

local diff = {
	"diff",
	symbols = {
		added = icons.git.LineAdded,
		modified = icons.git.LineModified,
		removed = icons.git.LineRemoved,
	},
	colored = false,
	cond = nil,
}

local config = function()
	require("lualine").setup({
		options = {
			theme = "auto",
			globalstatus = true,
			section_separators = {
				left = icons.ui.BoldDividerRight,
				right = icons.ui.BoldDividerLeft,
			},
			component_separators = {
				left = icons.ui.DividerLeft,
				right = icons.ui.DividerRight,
			},
			disabled_filetypes = { "alpha", "dashboard", "Outline" },
			ignore_focus = { "NvimTree" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{ "branch", icon = icons.git.Branch, separator = "" },
				"buffers",
			},
			lualine_c = { diff, diagnostics, venv },
			-- lualine_c = { diff, swenv, diagnostics },
			lualine_x = { lsp, "encoding", "fileformat", "filetype" },
			lualine_y = { "location" },
			lualine_z = { "progress" },
		},
		extensions = {},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
