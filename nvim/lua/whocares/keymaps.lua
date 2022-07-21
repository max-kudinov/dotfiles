local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Explore column
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Resize windows
keymap("n", "<S-k>", ":resize +2<CR>", opts)
keymap("n", "<S-j>", ":resize -2<CR>", opts)
keymap("n", "<S-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-l>", ":bnext<CR>", opts)
keymap("n", "<A-h>", ":bprevious<CR>", opts)

-- Just random stuff I wanna add
keymap("n", ";", "$", opts)
keymap("n", "d;", "d$", opts)
keymap("n", "<leader>h", ":noh<CR>", opts)

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
