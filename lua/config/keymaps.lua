local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) -- navigate left
keymap.set("n", "<C-l>", "<C-w>l", opts) -- navigate right
keymap.set("n", "<C-k>", "<C-w>k", opts) -- navigate up
keymap.set("n", "<C-j>", "<C-w>j", opts) -- navigate down
keymap.set("n", "<C-h>", "TmuxNavigateLeft<CR>", opts) -- Navigate Left
keymap.set("n", "<C-l>", "TmuxNavigateRight<CR>", opts) -- navigate right
keymap.set("n", "<C-k>", "TmuxNavigateUp<CR>", opts) -- navigate up
keymap.set("n", "<C-j>", "TmuxNavigateDown<CR>", opts) -- navigate down

-- window resize
keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- indenting
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- comments ("_" is same as "/")
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })

-- move buffer to right and bottom split
vim.api.nvim_set_keymap("n", "<C-v>", ":vsplit<CR><C-w>L", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-x>", ":split<CR><C-w>J", { noremap = true, silent = true })

-- disable ctrl+z backgrounding
vim.api.nvim_set_keymap("n", "<C-z>", "<nop>", { noremap = false })
vim.api.nvim_set_keymap("i", "<C-z>", "<nop>", { noremap = false })
