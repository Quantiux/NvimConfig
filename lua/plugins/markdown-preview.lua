local config = function()
	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>mp"] = { ":MarkdownPreview<CR>", "Open preview" },
		["<leader>mc"] = { ":MarkdownPreviewStop<CR>", "Close preview" },
	})
end

return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = config,
}
