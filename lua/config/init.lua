local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("config.globals")
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- lazy options to pass inside require().setup() at the bottom
local opts = {
	defaults = {
		lazy = true, -- set to false inside individual plugin config as needed
		version = nil, -- use latest commit ("*" to use latest tag if plugin supports semver)
	},
	change_detection = {
		enabled = true, -- automatically check for config file changes and reload the ui
		notify = false, -- get a notification when changes are found
	},
	performance = {
		rtp = {
			disabled_plugins = { -- disable native neovim plugins to avoid conflict
				"gzip",
				"matchit",
				"matchparen",
				"netrw",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	ui = {
		border = "rounded",
		size = { width = 0.8, height = 0.8 },
	},
	checker = {
		enabled = false, -- check for updates
		notify = false,
		frequency = 21600, -- check for updates every 6 hours
		check_pinned = false, -- check for pinned (non-upgradable) packages
	},
}

require("lazy").setup("plugins", opts) -- load plugins from ../plugins/init.lua
