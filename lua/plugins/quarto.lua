local config = function()
	local quarto = require("quarto")
	quarto.setup({
		debug = false,
		closePreviewOnExit = true,
		lspFeatures = {
			enabled = true,
			chunks = "curly",
			languages = { "r", "python" },
			diagnostics = {
				enabled = true,
				triggers = { "BufWritePost" },
			},
			completion = {
				enabled = true,
			},
		},
		codeRunner = {
			enabled = false,
			default_method = nil, -- 'molten' or 'slime'
			ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
			-- Takes precedence over `default_method`
			never_run = { "yaml" }, -- filetypes which are never sent to a code runner
		},
	})
end

return {
	"quarto-dev/quarto-nvim",
	ft = { "quarto" },
	dependencies = {
		"jmbuhr/otter.nvim",
	},
	config = config,
}
