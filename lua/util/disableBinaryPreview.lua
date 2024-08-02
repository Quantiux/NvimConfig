-- Disable binary file preview in Telescope
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes

-- pcall catches "Failed to load telescope.previewers" error on install
local previewers_status, previewers = pcall(require, "telescope.previewers")
if not previewers_status then
    print("Telescope previewers not found")
    return
end
local Job = require("plenary.job")
local disable_binary_preview = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" or filepath:match("%.json$") then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
                -- Preserve file type for syntax highlighting
                vim.schedule(function()
                    local filetype = vim.filetype.match({ filename = filepath, buf = bufnr })
                    vim.api.nvim_set_option_value("filetype", filetype, { buf = bufnr })
                end)
            else
                -- maybe we want to write something to the buffer here
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(
                        bufnr,
                        0,
                        -1,
                        false,
                        { "Binary file: preview disabled" }
                    )
                end)
            end
        end,
    }):sync()
end

return disable_binary_preview

