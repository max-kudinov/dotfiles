local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<A-h>", "<cmd> lua require('smart-splits').move_cursor_left()<CR>", opts)
keymap("n", "<A-j>", "<cmd> lua require('smart-splits').move_cursor_down()<CR>", opts)
keymap("n", "<A-k>", "<cmd> lua require('smart-splits').move_cursor_up()<CR>", opts)
keymap("n", "<A-l>", "<cmd> lua require('smart-splits').move_cursor_right()<CR>", opts)

-- Explore column
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Resize windows
keymap("n", "<C-h>", "<cmd> lua require('smart-splits').resize_left()<CR>", opts)
keymap("n", "<C-j>", "<cmd> lua require('smart-splits').resize_down()<CR>", opts)
keymap("n", "<C-k>", "<cmd> lua require('smart-splits').resize_up()<CR>", opts)
keymap("n", "<C-l>", "<cmd> lua require('smart-splits').resize_right()<CR>", opts)

-- Window splits
keymap("n", "<leader>h", "<cmd> vsplit<CR>", opts)
keymap("n", "<leader>v", "<cmd> split<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Just random stuff I wanna add
keymap("n", ";", "$", opts)
keymap("n", "d;", "d$", opts)
keymap("n", "<leader>n", ":noh<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Don't yank when replacing
keymap("v", "p", '"_dP', opts)

-- Telescope
keymap("n", "<leader>f", "<cmd> lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader>w", "<cmd> lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<leader>d", "<cmd> lua require('telescope.builtin').lsp_definitions()<CR>", opts)
keymap("n", "<leader>t", "<cmd> lua require('telescope.builtin').lsp_type_definitions()<CR>", opts)
keymap("n", "<leader>R", "<cmd> lua require('telescope.builtin').lsp_references()<CR>", opts)

-- Gitsigns
keymap("n", "<leader>gj", "<cmd> Gitsigns next_hunk<CR>", opts)
keymap("n", "<leader>gk", "<cmd> Gitsigns prev_hunk<CR>", opts)
keymap("n", "<leader>gp", "<cmd> Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>gb", "<cmd> Gitsigns blame_line<CR>", opts)

-- Bufferline
keymap("n", "<leader>bp", "<cmd> BufferLinePick<CR>", opts)
keymap("n", "<leader>bc", "<cmd> BufferLinePickClose<CR>", opts)
