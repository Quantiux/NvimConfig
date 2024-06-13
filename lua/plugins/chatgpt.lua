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

	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>Cc"] = { ":ChatGPT<CR>", "ChatGPT" },
		["<leader>Cx"] = { ":ChatGPTRun explain_code<CR>", "Explain code", mode = { "n", "v" } },
		["<leader>Cf"] = { ":ChatGPTRun fix_bugs<CR>", "Fix bugs", mode = { "n", "v" } },
		["<leader>Co"] = { ":ChatGPTRun optimize_code<CR>", "Optimize code", mode = { "n", "v" } },
		["<leader>Ca"] = { ":ChatGPTRun add_tests<CR>", "Add tests", mode = { "n", "v" } },
		["<leader>CC"] = { ":ChatGPTCompleteCode<CR>", "CodeCompletion", mode = { "n", "v" } },
		["<leader>Ce"] = {
			":ChatGPTEditWithInstructions<CR>",
			"Edit with instruction",
			mode = { "n", "v" },
		},
		["<leader>Cg"] = {
			":ChatGPTRun grammar_correction<CR>",
			"Grammar Correction",
			mode = { "n", "v" },
		},
		["<leader>Ct"] = { ":ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
		["<leader>Cs"] = { ":ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
		["<leader>Cl"] = {
			":ChatGPTRun code_readability_analysis<CR>",
			"Code Readability Analysis",
			mode = { "n", "v" },
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
