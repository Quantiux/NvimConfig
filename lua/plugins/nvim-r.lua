local config = function()
    vim.cmd[[
        autocmd TermOpen * setlocal nonu nornu      " no line number for console
        let R_auto_start = 1                        " do not autostart console with script
        let R_assign = 0                            " avoid '_' being substituted by '<-' in insert mode
        let R_hl_term = 1                           " enable output highlighting (default)
        let Rout_more_colors = 1                    " enable output command highlighting as in script
        let R_objbr_place = 'script,right'          " open object pane right of script
        let R_objbr_h = 10                          " height of object pane (if opens below)
        let R_objbr_w = 40                          " width of object pane (if opens right)
    ]]
end

return {
  "jalvesaq/Nvim-R",
  dependencies = {
    "jalvesaq/cmp-nvim-r",
  },
  lazy = false,
  config = config,
}
