local config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
	require("luasnip.loaders.from_vscode").lazy_load()

	-- load R-completion plugin
	require("cmp_r").setup({})

	-- Set up regular completion (including path completion)
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
			{ name = "buffer" }, -- text within current buffer
			{ name = "path", option = { label_trailing_slash = true } }, -- file system paths
			{ name = "cmp_r" }, -- R
		}),
		-- configure menu display
		formatting = {
			fields = { "abbr", "menu" },
			format = function(entry, vim_item)
				-- Source
				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					luasnip = "[Snippet]",
					cmp_tabnine = "[TabNine]",
					buffer = "[Buffer]",
					path = "[Path]",
					cmp_r = "[R]",
				})[entry.source.name] or ""
				-- Kind icons
				vim_item.kind = ""
				return vim_item
			end,
		},
	})

	-- Set up cmdline completion
	-- Use buffer source for "/" and "?"
	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})
	-- Use cmdline & path source for ":"
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
			{
				name = "cmdline",
				option = {
					ignore_cmds = { "Man", "!" },
					treat_trailing_slash = true,
				},
			},
		}),
	})
end

return {
	"hrsh7th/nvim-cmp",
	config = config,
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-cmdline", -- source for commandline suggestions
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*", -- follow latest release
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"R-nvim/cmp-r", -- R autocompletion
	},
}
