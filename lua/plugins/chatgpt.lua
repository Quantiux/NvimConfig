local config = function()
	local home = vim.fn.expand("$HOME")
	local chatgpt = require("chatgpt")
	chatgpt.setup({
		api_key_cmd = "gpg --quiet -d " .. home .. "/Documents/Keys/OpenaiAPI.txt.gpg",
		popup_layout = {
			default = "right",
			right = {
				width = "45%",
			},
		},
		openai_params = {
			max_tokens = 1000,
		},
	})
end

return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = config,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
