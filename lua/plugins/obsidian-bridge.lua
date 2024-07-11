local config = function()
	require("obsidian-bridge").setup({
		-- "27124" is encrypted server port, "27123" is non-encrypted port (see under "advanced
		-- settings" for "Local REST API with Scroll" plugin in Obsidian)
		obsidian_server_address = "https://localhost:27124",
		scroll_sync = true,
	})

	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>oo"] = { ":ObsidianOpen<CR>", "Open a note" },
		["<leader>on"] = { ":ObsidianNew<CR>", "Create a new note" },
		["<leader>of"] = { ":ObsidianSearch<CR>", "Find a note" },
		["<leader>oq"] = { ":ObsidianQuickSwitch<CR>", "Quickly switch note" },
		["<leader>ol"] = { ":ObsidianFollowLink<CR>", "Follow link under cursor" },
		["<leader>ob"] = { ":ObsidianBacklinks<CR>", "Get links list to buffer" },
		["<leader>om"] = { ":ObsidianLink<CR>", "Link selected text to note" },
		["<leader>op"] = { ":ObsidianLinkNew<CR>", "Create a note with link text" },
		["<leader>ot"] = { ":ObsidianTemplate<CR>", "Insert template" },
		["<leader>oT"] = { ":ObsidianTags<CR>", "Get reference list for tag" },
		["<leader>or"] = { ":ObsidianPasteImg<CR>", "Paste image from vault" },
		["<leader>ox"] = { ":ObsidianToggleCheckbox<CR>", "Cycle through checkbox options" },
		["<leader>og"] = { ":ObsidianBridgeOpenGraph<CR>", "Open Obsidian graph view" },
		["<leader>ov"] = {
			":ObsidianBridgeOpenVaultMenu<CR>",
			"Open Obsidian vault selection dialog",
		},
	})
end

return {
	"oflisback/obsidian-bridge.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	event = {
		"BufReadPre *.md",
		"BufNewFile *.md",
	},
	config = config,
}
