local opts = {
  indent = {
    char = "┊",   -- '|' / '¦' / '┆' / '┊'
  },
}

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  lazy = false,         -- always load
  opts = opts,
}
