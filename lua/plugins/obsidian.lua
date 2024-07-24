local config = function()
	require("obsidian").setup({

		-- workspace path
		workspaces = {
			{
				name = "Notes",
				path = "/home/roy/Documents/Notes",
			},
		},

		notes_subdir = "ZK",
		new_notes_location = "notes_subdir",

		-- completion stuff
		completion = {
			nvim_cmp = true,
			min_chars = 2, -- trigger completion after 2 characters
		},

		-- configure key mappings
		mappings = {}, -- disable default keymappings

		----------------------------------------------
		-- frontmatter stuff
		----------------------------------------------
		disable_frontmatter = false,

		-- customize how note IDs are generated given an optional title.
		note_id_func = function(title)
			local suffix = ""
			-- Create a Zettelkasten-styled ID with a timestamp and a suffix
			if title ~= nil then
				-- for example '1657296016-my-new-note'
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(os.time()) .. "-" .. suffix
		end,

		-------------------------------------------------------------------------------------------
		-- plugin currently does not allow adding more fields like note type ("tech", "research",
		-- "science", "idea", "random", "junk",...) to frontmatter, beyond what is supported (id,
		-- aliases, tags). One way around is to use type as a tag
		-------------------------------------------------------------------------------------------
		note_frontmatter_func = function(note)
			-- Add the title of the note as an alias (disabled: manually enter aliases instead).
			-- if note.title then
			-- 	note:add_alias(note.title)
			-- end

			-- `note.metadata` contains any manually added fields in the frontmatter.
			-- So here we just make sure those fields are kept in the frontmatter.
			local out = { id = note.id, aliases = note.aliases, tags = note.tags }
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end
			return out
		end,

		-- customize how note file names are generated given the ID, target directory, and title.
		note_path_func = function(spec)
			-- This is equivalent to the default behavior.
			local path = spec.dir / tostring(spec.id)
			return path:with_suffix(".md")
		end,

		----------------
		-- Link stuff
		----------------
		-- customize how wiki and markdown links are formatted. You can set this to one of:
		--  * "use_alias_only", e.g. '[[Foo Bar]]'
		--  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
		--  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
		--  * "use_path_only", e.g. '[[foo-bar.md]]'
		-- Or you can set it to a function that takes a table of options and returns a string, like this:
		wiki_link_func = function(opts)
			return require("obsidian.util").wiki_link_id_prefix(opts)
		end,

		markdown_link_func = function(opts)
			return require("obsidian.util").markdown_link(opts)
		end,

		preferred_link_style = "wiki", -- 'wiki' or 'markdown'

		-- by default when you use `:ObsidianFollowLink` on a link to an external
		-- URL it will be ignored but you can customize this behavior here.
		follow_url_func = function(url)
			vim.fn.jobstart({ "xdg-open", url }) -- Open the URL in the default browser.
		end,

		-----------------
		-- template stuff
		-----------------
		templates = {
			folder = "Extras/Templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			tags = "",
			substitutions = {}, -- A map for custom variables with key: variable, value: function
		},

		--------------------------
		-- image attachment stuff
		--------------------------
		-- customize default name/prefix when pasting images via `:ObsidianPasteImg`
		image_name_func = function()
			return string.format("%s-", os.time()) -- prefix image names with timestamp
		end,

		attachments = {
			img_folder = "Extras/Attachments",
			-- A function that determines the text to insert in the note when pasting an image.
			-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
			-- This is the default implementation.
			img_text_func = function(client, path)
				path = client:vault_relative_path(path) or path
				return string.format("![%s](%s)", path.name, path)
			end,
		},

		--------------------------
		-- picker stuff
		--------------------------
		picker = {
			name = "telescope.nvim", -- Set your preferred picker.
			-- configure key mappings for the picker.
			mappings = {
				new = "<C-x>", -- Create a new note from your query.
				insert_link = "<C-l>", -- Insert a link to the selected note.
			},
		},

		-- configure additional syntax highlighting / extmarks (set `conceallevel` to 1 or 2).
		ui = {
			enable = true,
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
