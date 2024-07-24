local config = function()
	require("obsidian-bridge").setup({
		-- "27124" is encrypted server port, "27123" is non-encrypted port (see under "advanced
		-- settings" for "Local REST API with Scroll" plugin in Obsidian)
		obsidian_server_address = "https://localhost:27124",
		scroll_sync = true,
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
