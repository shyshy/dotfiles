-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- gsub string that's under cursor
vim.keymap.set("n", "<Leader>s", ":%s/\\<<C-r><C-w>\\>/", { noremap = true })

-- space to unhighlight searches
vim.keymap.set("n", "<Space>", ":nohlsearch<Bar>:echo<CR>", { noremap = true, silent = true })

-- Toggle line numbers
vim.keymap.set("n", "<F2>", ":set nonumber!<CR>", { noremap = true })

-- Quick save and quit
vim.keymap.set("n", ",s", ":w<CR>", { noremap = true })
vim.keymap.set("n", ",q", ":wq<CR>", { noremap = true })

-- Edit file in current directory
vim.keymap.set("n", "<Leader>e", ':e <C-R>=expand("%:p:h") . "/"<CR>', { noremap = true })

-- Vertical split in current directory
vim.keymap.set("n", "<Leader>v", ':vsp <C-R>=expand("%:p:h") . "/"<CR>', { noremap = true })

-- Horizontal split in current directory
vim.keymap.set("n", "<Leader>p", ':sp <C-R>=expand("%:p:h") . "/"<CR>', { noremap = true })

-- Yank to system clipboard
vim.keymap.set("", "<Leader>c", '"+y', { noremap = true })
