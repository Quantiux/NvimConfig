local icons = require("util.icons") -- attach icons from util/icons.lua

-- get python environment
local swenv = {
	"swenv",
	icons_enabled = true,
	icon = "󰌠",
	-- color = { fg = "#61afef" },
}

-- script below is for additional customization of python venv name string
-- local split = function(input, delimiter)
-- 	local arr = {}
-- 	_ = string.gsub(input, "[^" .. delimiter .. "]+", function(w)
-- 		table.insert(arr, w)
-- 	end)
-- 	return arr
-- end
--
-- local py_env = function(env)
-- 	if env then
-- 		local name = split(env, "-") -- split name by '-'
-- 		return ("[ " .. name[1] .. "]")
-- 	end
-- 	return ""
-- end
--
-- local venv = {
-- 	py_env("swenv"),
-- 	icons_enabled = false,
-- 	icon = nil,
-- 	color = { fg = "#61afef" },
-- }

-- LSP clients attached to buffer
local clients_lsp = function()
	local clients = vim.lsp.get_clients()
	if #clients == 0 then
		return "LSP Inactive"
	end

	-- add client
	local c = {}
	for _, client in pairs(clients) do
		table.insert(c, client.name)

		-- -- If the client is efm, collect its tools
		-- if client.name == "efm" then
		-- 	local efm_cfg = require("lspconfig").efm.get_config()
		-- 	local active_tools = {}
		-- 	if efm_cfg and efm_cfg.settings and efm_cfg.settings.languages then
		-- 		for lang, tools in pairs(efm_cfg.settings.languages) do
		-- 			local tool_names = {}
		-- 			for _, tool in ipairs(tools) do
		-- 				if tool.formatCommand then
		-- 					table.insert(tool_names, "formatter: " .. tool.formatCommand)
		-- 				end
		-- 				if tool.lintCommand then
		-- 					table.insert(tool_names, "linter: " .. tool.lintCommand)
		-- 				end
		-- 			end
		-- 			if #tool_names > 0 then
		-- 				table.insert(active_tools, lang, tool_names)
		-- 				-- table.insert(active_tools, lang .. " (" .. table.concat(tool_names, ", ") .. ")")
		-- 			end
		-- 		end
		-- 	end
		-- 	if #active_tools > 0 then
		-- 		table.insert(c, active_tools)
		-- 		-- table.insert(c, table.concat(active_tools, " | "))
		-- 	end
		-- end
	end

	return "[" .. table.concat(c, ",") .. "]"
end
local lsp = {
	clients_lsp,
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
				left = icons.ui.BoldDividerSlantLeft,
				right = icons.ui.BoldDividerSlantRight,
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
			lualine_c = { diff, swenv, diagnostics },
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
