local config = function()
	local swenv = require("swenv")
	swenv.setup({
		venvs_path = vim.fn.expand("~/.local/share/virtualenvs"), -- pipenv path
		post_set_venv = function()
			vim.cmd("LspRestart") -- restart lsp after switching venv
		end,
	})
end

return {
	"AckslD/swenv.nvim",
	config = config,
}
