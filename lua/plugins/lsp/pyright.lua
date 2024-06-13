-- https://github.com/microsoft/pyright/blob/main/docs/configuration.md
-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
return {
  settings = {
    pyright = {
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly", -- openFilesOnly / workspace
        diagnosticSeverityOverrides = {
          -- reportGeneralTypeIssues = false,
          reportUnusedImport = false,
        },
        typeCheckingMode = "basic", -- off / basic / strict
        useLibraryCodeForTypes = true,
      },
    },
  },
}
