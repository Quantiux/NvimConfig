local config = function()
  local code_runner = require("code_runner")    -- load code_runner
  local betterTerm = require("betterTerm")    -- load betterTerm

  code_runner.setup({
    filetype = {
      python = "python3 -u",
    },
  })

  betterTerm.setup({
    prefix = "Term_",
    startInserted = true,
    position = "bot",
    size = 17,
  })

end

return {
  "CRAG666/code_runner.nvim",
  dependencies = {
    "CRAG666/betterTerm.nvim",
  },
  config = config,
}
