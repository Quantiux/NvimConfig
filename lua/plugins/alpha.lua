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
	dashboard.section.footer.val = { "https://quantiux.com" }

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
