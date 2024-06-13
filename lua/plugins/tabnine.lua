local config = function()
	local tabnine = require("cmp_tabnine.config")
	tabnine:setup({ -- notice the ":" instead of "."
		ignored_file_types = {
			lua = true,
			html = true,
		},
	})
end

return {
	"tzachar/cmp-tabnine",
	build = "./install.sh",
	dependencies = "hrsh7th/nvim-cmp",
	event = "BufRead",
	config = config,
}
