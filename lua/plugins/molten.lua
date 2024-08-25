-- https://github.com/benlubas/molten-nvim/blob/main/docs/minimal.lua

-- add path to molten's environment
vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

return {
	"benlubas/molten-nvim",
	dependencies = { "3rd/image.nvim" },
	build = ":UpdateRemotePlugins",
	init = function()
		-- https://github.com/benlubas/molten-nvim/tree/main?tab=readme-ov-file#configuration
		vim.g.molten_image_provider = "image.nvim"
		vim.g.molten_auto_image_popup = false
		vim.g.molten_auto_open_output = false
		vim.g.molten_enter_output_behavior = "open_then_enter"
		vim.g.molten_open_cmd = nil
		vim.g.molten_output_show_exec_time = true
		vim.g.molten_output_win_hide_on_leave = true
		vim.g.molten_split_direction = "right"
		vim.g.molten_split_size = 40
		vim.g.molten_use_border_highlights = true
		vim.g.molten_virt_text_output = false
		vim.g.molten_wrap_output = false
	end,
}
