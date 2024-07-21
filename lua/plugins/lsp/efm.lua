-- https://github.com/creativenull/efmls-configs-nvim/tree/main/lua/efmls-configs
-- load default settings for linters/formatters from efmls-configs plugin
-----------------------------------------------------------------------------------
-- install luacheck, stylua, flake8, isort, black, markdownlint, mdformat via Mason
-----------------------------------------------------------------------------------
local luacheck = require("efmls-configs.linters.luacheck")
local stylua = require("efmls-configs.formatters.stylua")
local flake8 = require("efmls-configs.linters.flake8")
local isort = require("efmls-configs.formatters.isort")
local black = require("efmls-configs.formatters.black")
local markdownlint = require("efmls-configs.linters.markdownlint")
local mdformat = require("efmls-configs.formatters.mdformat")

return {
	filetypes = { "lua", "python", "markdown" },
	settings = {
		languages = {
			lua = { luacheck, stylua },
			python = { flake8, isort, black },
			markdown = { markdownlint, mdformat },
		},
		-- place these linter/formatter config files in $HOME (for global scope)
		rootMarkers = {
			".luacheckrc",
			".luarc.json",
			".flake8",
			".markdownlint.yaml",
			".mdformat.toml",
			".stylua.toml",
			"pyproject.toml",
		},
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		hover = true,
		documentSymbol = true,
		codeAction = true,
		completion = true,
	},
}
