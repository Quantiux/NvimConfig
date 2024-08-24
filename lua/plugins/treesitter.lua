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
			"bash",
			"dockerfile",
			"lua",
			"markdown", -- for basic highlighting
			"markdown_inline", -- for full highlighting
			"python",
			"r",
			"regex",
			"rnoweb",
			"vim",
			"vimdoc",
			"yaml",
			-- "html", -- to render image from html file (see image.lua)
			-- "css", -- to render image from css file (see image.lua)
		},
		sync_install = true,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate", -- update parsers during each treesitter update
	lazy = false, -- always load
	config = config,
}
