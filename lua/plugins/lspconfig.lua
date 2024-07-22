-- https://github.com/LunarVim/Launch.nvim/blob/master/lua/user/lspconfig.lua

local config = function()
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")

	-- customize how diagnostics are displayed
	local icons = require("util.icons").diagnostics -- get icons from util/icons.lua
	local my_diagnostic_config = { -- change default diagnostics config
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.Error },
				{ name = "DiagnosticSignWarn", text = icons.Warn },
				{ name = "DiagnosticSignHint", text = icons.Hint },
				{ name = "DiagnosticSignInfo", text = icons.Info },
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

	-- rounded border for floating window of lsp text document
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
	vim.lsp.handlers["textDocument/hover"] =
		vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	require("lspconfig.ui.windows").default_options.border = "rounded"

	-- add lsp to completion source
	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- keybinding for lsp defs/refs/.. (attatched to active lsp server)
	local on_attach = function(_, bufnr)
		local opts = { noremap = true, silent = true }
		local keymap = vim.api.nvim_buf_set_keymap
		keymap(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
		keymap(bufnr, "n", "gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
		keymap(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
		keymap(bufnr, "n", "gI", ":lua vim.lsp.buf.implementation()<CR>", opts)
		keymap(bufnr, "n", "gr", ":lua vim.lsp.buf.references()<CR>", opts)
		keymap(bufnr, "n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts)
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
		lspconfig[server].setup(opts) -- pass configs to lspconfig
	end

	-- which-key mapping
	local wk = require("which-key")
	wk.register({
		["<leader>li"] = { ":LspInfo<CR>", "Info" },
		["<leader>lj"] = { ":lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
		["<leader>lk"] = { ":lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },
		["<leader>la"] = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
		["<leader>ll"] = { ":lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
		["<leader>lq"] = { ":lua vim.diagnostic.setloclist()<CR>", "Quickfix" },
		["<leader>lr"] = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
		["<leader>lf"] = { ":lua vim.lsp.buf.format{async=true}<CR>", "Format" },
	})
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = config,
}
