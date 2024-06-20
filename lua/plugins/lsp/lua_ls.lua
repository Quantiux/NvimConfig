return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- make language server recognize "vim" global
			},
			workspace = {
				checkThirdParty = false,
				library = {
					-- https://www.reddit.com/r/neovim/comments/1cu2hky/comment/l4svv9z/
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("config") .. "/lua",
					-- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
					-- [vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			hint = {
				enable = false,
				arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
				await = true,
				paramName = "Disable", -- "All" | "Literal" | "Disable"
				paramType = true,
				semicolon = "All", -- "All" | "SameLine" | "Disable"
				setType = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
