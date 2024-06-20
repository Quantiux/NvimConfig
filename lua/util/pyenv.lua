-- add python virtual environment to lualine
-- Custom split function
local split = function(input, delimiter)
	local arr = {}
	for str in string.gmatch(input, "([^" .. delimiter .. "]+)") do
		table.insert(arr, str)
	end
	return arr
end

local get_venv = function()
	local venv = os.getenv("VIRTUAL_ENV") -- check with :lua print(os.getenv("VIRTUAL_ENV"))
	if venv then
		local params = split(venv, "/") -- split path by '/'
		local name = split(params[#params], "-") -- split name by '-'
		return ("[ " .. name[1] .. "]")
	else
		return ""
	end
end

return get_venv
