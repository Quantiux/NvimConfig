local config = function()
	require("obsidian").setup({
		workspaces = {
			{
				name = "Notes",
				path = "/home/roy/Documents/Notes",
			},
		},

		notes_subdir = "Zettelkasten",
		new_notes_location = "notes_subdir",

		preferred_link_style = "wiki", -- 'wiki' or 'markdown'

		completion = {
			nvim_cmp = true,
			min_chars = 2, -- trigger completion after 2 characters
		},

		-- customize default name/prefix when pasting images via `:ObsidianPasteImg`
		---@return string
		image_name_func = function()
			return string.format("%s-", os.time()) -- prefix image names with timestamp
		end,

		mappings = {},

		disable_frontmatter = false,
		---@return table
		note_frontmatter_func = function(note)
			if note.title then
				note:add_alias(note.title) -- add title of the note as an alias
			end

			local out = { id = note.id, aliases = note.aliases, tags = note.tags }
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end

			return out
		end,

		templates = {
			folder = "Templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			substitutions = {},
		},

		attachments = {
			img_folder = "Attachments",
		},

		ui = {
			enable = true,
		},
	})

	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>oo"] = { ":ObsidianOpen<CR>", "Open a note" },
		["<leader>on"] = { ":ObsidianNew<CR>", "Create a new note" },
		["<leader>of"] = { ":ObsidianSearch<CR>", "Find a note" },
		["<leader>oq"] = { ":ObsidianQuickSwitch<CR>", "Quickly switch note" },
		["<leader>ol"] = { ":ObsidianFollowLink hsplit<CR>", "Follow link under cursor" },
		["<leader>ob"] = { ":ObsidianBacklinks<CR>", "Get links list to buffer" },
		["<leader>om"] = { ":ObsidianLink<CR>", "Link selected text to note" },
		["<leader>op"] = { ":ObsidianLinkNew<CR>", "Create a note with link text" },
		["<leader>ot"] = { ":ObsidianTemplate<CR>", "Insert template" },
		["<leader>oT"] = { ":ObsidianTags<CR>", "Get reference list for tag" },
		["<leader>or"] = { ":ObsidianPasteImg<CR>", "Paste image from vault" },
		["<leader>ox"] = { ":ObsidianToggleCheckbox<CR>", "Cycle through checkbox options" },
	})
end

return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = config,
}
