local icons = require("util.icons") -- attach icons from util/icons.lua

local config = function()
	local mason = require("mason") -- load mason
	local mason_lspconfig = require("mason-lspconfig") -- load mason-lspconfig

	mason.setup({ -- set up mason
		ui = {
			border = "rounded",
			width = 0.8,
			height = 0.8,
			icons = {
				package_installed = icons.ui.Installed,
				package_pending = icons.ui.Right,
				package_uninstalled = icons.ui.Uninstalled,
			},
		},
	})

	mason_lspconfig.setup({ -- set up mason-lspconfig
		ensure_installed = {  -- auto-install these language servers
			"efm", -- this is for linting / formatting
			"lua_ls",
			"pyright",
			-- "r_language_server", -- use Nvim-R instead
		},
		automatic_installation = true,
	})
end

return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	cmd = "Mason",
	event = { "BufReadPre", "BufNewFile" },
	config = config,
}
