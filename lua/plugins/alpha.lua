local config = function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	-- Set header
	dashboard.section.header.val = {
		"",
		"",
		-- "",
		"",
		" ██████╗ ██╗   ██╗ █████╗ ███╗   ██╗████████╗██╗██╗   ██╗██╗  ██╗",
		"██╔═══██╗██║   ██║██╔══██╗████╗  ██║╚══██╔══╝██║██║   ██║╚██╗██╔╝",
		"██║   ██║██║   ██║███████║██╔██╗ ██║   ██║   ██║██║   ██║ ╚███╔╝ ",
		"██║▄▄ ██║██║   ██║██╔══██║██║╚██╗██║   ██║   ██║██║   ██║ ██╔██╗ ",
		"╚██████╔╝╚██████╔╝██║  ██║██║ ╚████║   ██║   ██║╚██████╔╝██╔╝ ██╗",
		" ╚══▀▀═╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═╝",
		"",
	}

	-- Set menu
	dashboard.section.buttons.val = {
		dashboard.button("e", "  New File", ":ene<CR>"),
		dashboard.button("f", "󰱼  Find File", ":Telescope find_files<CR>"),
		dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
		dashboard.button("p", "  Projects", ":NvimTreeOpen ~/Projects<CR>"),
		dashboard.button("d", "  Documents", ":NvimTreeOpen ~/Documents<CR>"),
		dashboard.button("n", "󰎚  Notes", ":NvimTreeOpen ~/Documents/Notes<CR>"),
		dashboard.button("t", "󰊄  Find Text", ":Telescope live_grep<CR>"),
		dashboard.button("c", "  Configuration", ":NvimTreeOpen ~/.config<CR>"),
		dashboard.button("h", "  Check health", ":checkhealth<CR>"),
		dashboard.button("q", "󰅖  Quit", ":qa<CR>"),
	}

	-- Set footer
	-- (https://github.com/goolord/alpha-nvim/discussions/16#discussioncomment-8866558)
	vim.api.nvim_create_autocmd("User", {
	  once = true,
		pattern = "LazyVimStarted",
		callback = function()
			local v = vim.version()
			local dev
			if v.prerelease == "dev" then
				dev = "-dev-" .. v.build
			else
				dev = ""
			end
			local version = v.major .. "." .. v.minor .. "." .. v.patch .. dev
			local stats = require("lazy").stats()
			local plugins_count = stats.loaded .. "/" .. stats.count
			local ms = math.floor(stats.startuptime + 0.5)
			local line1 = " " .. plugins_count .. " plugins loaded in " .. ms .. "ms"
			local line2 = "( " .. version .. ")"
			local line1_width = vim.fn.strdisplaywidth(line1)
			local line2Padded = string.rep(" ", (line1_width - vim.fn.strdisplaywidth(line2)) / 2)
				.. line2

			dashboard.section.footer.val = {
				line1,
				line2Padded,
			}
			pcall(vim.cmd.AlphaRedraw)
		end,
	})

	-- dashboard.section.footer.val = { "https://quantiux.com" }

	-- Send config to alpha
	alpha.setup(dashboard.opts)

	-- Disable folding on alpha buffer
	vim.cmd("autocmd FileType alpha setlocal nofoldenable")
end

return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = config,
}
