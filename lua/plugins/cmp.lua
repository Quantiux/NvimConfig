local config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	local kind_icons = require("util.icons").kind -- attach icons from util/icons.lua

	-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
	require("luasnip.loaders.from_vscode").lazy_load()
	
	vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })  -- set TabNine color

	cmp.setup({
		completion = {
			completeopt = "menu,menuone,preview,noselect",
		},
		snippet = { -- configure how nvim-cmp interacts with snippet engine
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
			["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
			["<Up>"] = cmp.mapping.select_prev_item(), -- previous suggestion
			["<Down>"] = cmp.mapping.select_next_item(), -- next suggestion
			["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
			["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
			["<C-e>"] = cmp.mapping.abort(), -- close completion window
			["<CR>"] = cmp.mapping.confirm({ select = false }),
		}),
		-- sources for autocompletion
		sources = cmp.config.sources({
			{ name = "nvim_lsp" }, -- lsp
			{ name = "luasnip" }, -- snippets
			{ name = "cmp_tabnine" }, -- cmp-tabnine
			{ name = "cmp_nvim_r" }, -- cmp-nvim-r
			{ name = "buffer" }, -- text within current buffer
			{ name = "path", option = { trailing_slash = true } }, -- file system paths
		}),
		-- configure icons
		formatting = {
		  fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				-- Kind icons
				vim_item.kind = kind_icons[vim_item.kind]
				-- Source
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					luasnip = "[Snippet]",
					cmp_tabnine = "[TabNine]",
					cmp_nvim_r = "[Nvim_R]",
					buffer = "[Buffer]",
					path = "[Path]",
				})[entry.source.name]
        if entry.source.name == "cmp_tabnine" then
          vim_item.kind_hl_group = "CmpItemKindTabnine"
        end
				return vim_item
			end,
		},
	})
end

return {
	"hrsh7th/nvim-cmp",
	config = config,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*", -- follow latest release
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
	},
}
