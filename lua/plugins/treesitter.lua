local config = function()
	require("nvim-treesitter.configs").setup({
		indent = {
			enable = true,
			-- disable = { "python" },   -- python indent works when disabled here
		},
		autopairs = {
			enable = true,
		},
		-- autotag = {
		--   enable = true,
		-- },
		ensure_installed = {
			"yaml",
			"bash",
			"lua",
			"dockerfile",
			"python",
			"r",
			"vim",
			"markdown", -- for basic highlighting
			"markdown_inline", -- for full highlighting
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate", -- update language parsers during each upgrade
	lazy = false, -- always load
	config = config,
}
