local config = function()
	require("oil").setup({
		default_file_explorer = true,
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true,
			max_width = 60,
		},
		win_options = {
			wrap = true,
		},
		float = {
			max_height = 20,
			max_width = 60,
			border = "rounded",
		},
	})
	vim.keymap.set("n", "-", ":Oil<CR>", { desc = "Open parent directory" })
end

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Oil",
	event = { "VimEnter */*,.*", "BufNew */*,.*" },
	config = config,
}
