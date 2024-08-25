-- necessary package prerequisites: ImageMagick, LuaJIT, magick (see Obsidian note on image rendering with Neovim)

-- path to load magick (~/.luarocks/share/lua/5.1/magick/init.lua)
package.path = package.path
	.. ";"
	.. vim.fn.expand("$HOME")
	.. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

local opts = {
	backend = "kitty",
	integrations = {
		markdown = {
			enabled = true,
			clear_in_insert_mode = false,
			download_remote_images = true,
			only_render_image_at_cursor = true,
			filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
		},
		neorg = {
			enabled = false,
		},
		html = { -- make sure treesitter html parser is installed
			enabled = false,
		},
		css = { -- make sure treesitter css parser is installed
			enabled = false,
		},
	},
	-- next 5 lines from https://github.com/benlubas/molten-nvim/blob/main/docs/Not-So-Quick-Start-Guide.md#after-imagenvim-is-working
	max_width = 120,
	max_height = 12,
	max_width_window_percentage = math.huge,
	max_height_window_percentage = math.huge,
	window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
	window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	editor_only_render_when_focused = false,
	tmux_show_only_in_active_window = false,
	hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
}

return {
	"3rd/image.nvim",
	event = "BufReadPre",
	opts = opts,
}
