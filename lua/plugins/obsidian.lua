local config = function()
	require("obsidian").setup({
		workspaces = {
			{
				name = "Notes",
				path = "/home/roy/Documents/Notes",
			},
		},
		preferred_link_style = "markdown", -- "markdown" or "wiki"

		-- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
		---@return string
		image_name_func = function()
			-- Prefix image names with timestamp.
			return string.format("%s-", os.time())
		end,

		-- Optional, boolean or a function that takes a filename and returns a boolean.
		-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
		disable_frontmatter = false,

		-- Optional, alternatively you can customize the frontmatter data.
		---@return table
		note_frontmatter_func = function(note)
			-- Add the title of the note as an alias.
			if note.title then
				note:add_alias(note.title)
			end

			local out = { id = note.id, aliases = note.aliases, tags = note.tags }

			-- `note.metadata` contains any manually added fields in the frontmatter.
			-- So here we just make sure those fields are kept in the frontmatter.
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end

			return out
		end,

		-- Optional, for templates (see below).
		templates = {
			folder = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},
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

