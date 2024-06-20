-- Return LSP clients attached to current buffer (to add to lualine)
-- Command structure for linters and formatters can be found in the link below:
-- https://github.com/creativenull/efmls-configs-nvim/tree/main/lua/efmls-configs
local clients_lsp = function()
	local bufnr = vim.api.nvim_get_current_buf() -- get current buffer number
	local clients = vim.lsp.get_clients({ bufnr = bufnr }) -- get LSP clients for current buffer
	if #clients == 0 then
		return "LSP Inactive"
	end

	-- function to extract tool name from command string (in case tool prefix is missing)
	local extract_tool_name = function(command)
		if command then
			local tool_name = command:match("([^/\\]+)$") -- extract last part of command path
			tool_name = tool_name:match("^[^ ]+") -- extract part before command arguments
			return tool_name
		end
		return ""
	end

	-- get current buffer's filetype
	local filetype = vim.bo.filetype

	-- add client
	local c = {}
	for _, client in pairs(clients) do
		local client_name = client.name
		table.insert(c, client_name)

		-- check if client is efm and add linters/formatters
		if client_name == "efm" then
			local efm_config = require("plugins.lsp.efm") -- load efm config dynamically

			-- check if current buffer's filetype is supported by efm
			if efm_config.settings.languages[filetype] then
				local tools = efm_config.settings.languages[filetype]
				for _, tool in ipairs(tools) do
					if tool.prefix then -- get tool name directly from prefix if exists
						table.insert(c, tool.prefix)
					else -- else extract tool name from its command string
						if tool.lintCommand then
							local lint_tool = extract_tool_name(tool.lintCommand)
							table.insert(c, lint_tool)
						end
						if tool.formatCommand then
							local format_tool = extract_tool_name(tool.formatCommand)
							table.insert(c, format_tool)
						end
					end
				end
			end
		end
	end

	return "[" .. table.concat(c, ",") .. "]"
end

return clients_lsp
