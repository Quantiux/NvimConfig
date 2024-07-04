-- Close all inactive buffers (source: https://chatgpt.com/c/0156148c-3a11-42ac-99bc-02034f47d1b3)

local close_inactive_buffers = function()
	-- Get the current buffer number
	local current_buf = vim.fn.bufnr("")
	-- Get a list of all listed buffers
	local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
	-- Iterate over all listed buffers
	for _, buf in ipairs(listed_buffers) do
		-- Check if the buffer is not the current buffer
		if buf.bufnr ~= current_buf then
			-- Delete the buffer
			vim.cmd("bdelete " .. buf.bufnr)
		end
	end
end

return close_inactive_buffers
