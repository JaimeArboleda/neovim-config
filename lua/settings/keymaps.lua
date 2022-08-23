-- common options
local opts = { silent = true }
-- shorten keymap nvim call
local keymap = vim.keymap.set

-- remap space as leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
-- remap \ as local leader (for special files)
vim.g.maplocalleader = "\\"

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "gb", ":bnext<CR>", opts)
keymap("n", "gB", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Movement on soft wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Interact with clipboard
keymap({ "n", "v" }, "<leader>cp", '"+p', { noremap = true })
keymap({ "n", "v" }, "<leader>cy", '"+y', { noremap = true })

-- Y yank to end of line, H move begin of line, L move end of line 
keymap({ "n", "v", "o" }, "H", "^", { noremap = true })
keymap({ "n", "v", "o" }, "L", "$", { noremap = true })
keymap("n", "Y", "y$", { noremap = true })
