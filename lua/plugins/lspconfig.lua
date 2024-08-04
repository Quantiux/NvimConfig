----------------------------------------------------------------------------
-- Setup to integrate all LSP features by combining mason, lspconfig, cmp
-- (https://lsp-zero.netlify.app/v3.x/blog/you-might-not-need-lsp-zero.html)
----------------------------------------------------------------------------
-- config needed at startup
local config_startup = function()
	require("neoconf").setup({})

	-- these 5 must follow this order (https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#setup)
	local mason = require("mason")
	local mason_lspconfig = require("mason-lspconfig")
	local mason_tool_installer = require("mason-tool-installer")
	local cmp_nvim_lsp = require("cmp_nvim_lsp") -- needed by lspconfig
	local lspconfig = require("lspconfig")

	local icons = require("util.icons") -- get icons

	-- Set up Mason (to install language servers)
	mason.setup({
		ui = {
			border = "rounded",
			width = 0.8,
			height = 0.8,
			icons = {
				package_installed = icons.ui.Installed,
				package_pending = icons.ui.Right,
				package_uninstalled = icons.ui.Uninstalled,
			},
		},
	})

	mason_lspconfig.setup({ -- auto-install language servers
		ensure_installed = {
			"efm", -- this language server is for managing linters & formatters
			"lua_ls",
			"pyright",
			"marksman",
			-- "r_language_server", -- use r-nvim instead
		},
		automatic_installation = true,
	})

	mason_tool_installer.setup({ -- auto-install linters & formatters
		ensure_installed = {
			"luacheck",
			"stylua",
			"flake8",
			"black",
			"isort",
			"markdownlint",
			-- "mdformat",
		},
		auto_update = false,
		run_on_start = true,
		start_delay = 3000, -- 3 second delay (if run_on_start = true)
		integrations = {
			["mason-lspconfig"] = true,
			["mason-null-ls"] = false, -- mason-null-ls not installed
			["mason-nvim-dap"] = false, -- mason-nvim-dap not installed
		},
	})

	--- Set up LSPconfig (to configure language servers)
	-- customize how diagnostics are displayed
	local my_diagnostic_config = { -- change default diagnostics config
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warn },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.Info },
			},
		},
		virtual_text = true,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}
	vim.diagnostic.config(my_diagnostic_config)
	-- add diagnostic signs in gutter
	local diagnostic_config = vim.diagnostic.config() or {}
	local signs = vim.tbl_get(diagnostic_config, "signs", "values") or {}
	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	-- rounded border for floating window of lsp text document (global)
	require("lspconfig.ui.windows").default_options.border = "rounded"

	-- add lsp to completion source
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- keybinding for lsp defs/refs/.. (attached to active lsp server)
	local on_attach = function(_, bufnr)
		local opts = { noremap = true, silent = true }
		local keymap = vim.api.nvim_buf_set_keymap
		keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
		keymap(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
		keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
		keymap(bufnr, "n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts)
		keymap(bufnr, "n", "gI", ":lua vim.lsp.buf.implementation()<CR>", opts)
		-- Use noice for hover and signature help
		keymap(bufnr, "n", "K", ":lua require('noice.lsp').hover()<CR>", opts)
		keymap(bufnr, "n", "gi", ":lua require('noice.lsp').signature_help()<CR>", opts)
	end

	-- loop through language servers to set up config
	local servers = { "efm", "lua_ls", "pyright", "marksman" }
	for _, server in pairs(servers) do
		local opts = {
			on_attach = on_attach,
			capabilities = capabilities,
		}
		-- get server settings from plugins/lsp/ folder if available (none for marksman)
		local has_settings, settings = pcall(require, "plugins.lsp." .. server)
		if has_settings then
			opts = vim.tbl_deep_extend("force", settings, opts)
		end
		lspconfig[server].setup(opts) -- pass configs to each server's lspconfig
	end
end

-- config needed at buffer open
local config_buffer_open = function()
	-- Set up Autocompletion (uses LSP)
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lspkind = require("lspkind")

	require("luasnip.loaders.from_vscode").lazy_load() -- loads vscode style snippets

	require("cmp_r").setup({}) -- load R-completion plugin

	vim.opt.completeopt = "menu,menuone,noselect"

	-- Set up regular completion (including path completion)
	cmp.setup({
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
			{ name = "path", option = { label_trailing_slash = true } }, -- file system paths
			{ name = "buffer" }, -- text within current buffer
			{ name = "cmp_r" }, -- R
		}),
		-- configure lspkind for vs-code like icons
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "...",
				show_labelDetails = true,
				menu = { -- showing type in menu
					nvim_lsp = "[LSP]",
					luasnip = "[Snippet]",
					cmp_tabnine = "[TabNine]",
					path = "[Path]",
					buffer = "[Buffer]",
					cmp_r = "[R]",
				},
			}),
		},
	})

	-- Set up cmdline completion
	cmp.setup.cmdline({ "/", "?" }, { -- Use buffer source for "/" and "?"
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", { -- Use cmdline & path source for ":"
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
	-- LSP support plugins loaded at startup
	{
		"creativenull/efmls-configs-nvim",
		version = "v1.x.x",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp", -- needed by nvim-lspconfig
			"neovim/nvim-lspconfig",
			"windwp/nvim-autopairs", -- needed by efmls-configs-nvim
		},
		lazy = false,
		config = config_startup,
	},

	-- Completion plugins loaded at buffer open
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"onsails/lspkind.nvim",
			{
				"L3MON4D3/LuaSnip",
				tag = "v2.*", -- Replace <CurrentMajor> by the latest released major
				build = "make install_jsregexp",
			},
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"R-nvim/cmp-r",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = config_buffer_open,
	},
}
