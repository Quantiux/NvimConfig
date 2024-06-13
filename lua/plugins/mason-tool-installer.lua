local opts = {
  -- ** auto-install does not work, manually install in mason window **
  ensure_installed = {      -- install linters / formatters
    "luacheck",
    "stylua",
    "flake8",
    "black",
    "isort",
  },
  auto_update = false,
  run_on_start = true,
}

return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = opts,
}
