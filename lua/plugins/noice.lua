local opts = {
	routes = {
		{
			view = "notify",
			filter = { event = "msg_showmode" },
		},
	},
	lsp = {
		progress = {
			enabled = false,
		},
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		-- either set hover, signature=false or comment out lines 'vim.lsp.handlers["textDocument/signatureHelp"] =' and 'vim.lsp.handlers["textDocument/hover"] =' in lspconfig.lua to avoid conflict
		hover = {
			enabled = false,
		},
		signature = {
			enabled = false,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = false, -- 'true' positions cmdline at the top
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
}

return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		{
			"rcarriga/nvim-notify",
			opts = {
				timeout = 3000,
				render = "compact",
				top_down = true,
				stages = "static",
			},
		},
	},

	opts = opts,
}
