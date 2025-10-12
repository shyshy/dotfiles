local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "Shougo/neosnippet.vim",
  "Shougo/neosnippet-snippets",
  "tpope/vim-fugitive",
  "tpope/vim-rake",
  "flazz/vim-colorschemes",
  "EdenEast/nightfox.nvim",
  "vim-ruby/vim-ruby",
  "dense-analysis/ale",
  "sunaku/vim-ruby-minitest",
  "godlygeek/tabular",
  "preservim/vim-markdown",
  "mustache/vim-mustache-handlebars",
  "sheerun/vim-polyglot",
  "fatih/vim-go",
  "tpope/vim-surround",
  "tpope/vim-projectionist",
  "bling/vim-airline",
  "edkolev/tmuxline.vim",
  "kien/rainbow_parentheses.vim",
  "rust-lang/rust.vim",
  "vim-test/vim-test",
  "christoomey/vim-tmux-navigator",
  "ruanyl/vim-gh-line",
  "ruby-formatter/rufo-vim",
  "github/copilot.vim"
})

-- Enable filetype detection, plugins, and indent
vim.cmd('filetype indent plugin on')

-- Enable syntax highlighting
vim.cmd('syntax on')

--- General settings
vim.opt.backspace = {'indent', 'eol', 'start'}
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.autoread = true
vim.opt.history = 1000
vim.opt.swapfile = true
vim.opt.directory = '/tmp'
vim.opt.scrolloff = 6
vim.opt.mouse = 'a'
vim.opt.fixeol = false

--- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

--- Disable folding (for vim-markdown)
vim.g.vim_markdown_folding_disabled = 1

--- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Number toggle autocommands
local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })
vim.api.nvim_create_autocmd({'BufEnter', 'FocusGained', 'InsertLeave'}, {
  group = numbertoggle,
  pattern = '*',
  command = 'set relativenumber'
})
vim.api.nvim_create_autocmd({'BufLeave', 'FocusLost', 'InsertEnter'}, {
  group = numbertoggle,
  pattern = '*',
  command = 'set norelativenumber'
})

--- Colors
vim.opt.termguicolors = true -- Modern alternative to t_Co=256
--- vim.opt.background = 'dark'
vim.cmd('colorscheme nightfox')

--- Tab complete
vim.opt.wildmenu = true
vim.opt.wildmode = {'list:longest', 'full'}

--- Statuslines (airline config)
vim.opt.laststatus = 2
vim.g.airline_powerline_fonts = 1
vim.g.airline_left_sep = ' '
vim.g.airline_right_sep = ' '
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#tab_nr_type'] = 1
vim.g['airline#extensions#tabline#show_tab_type'] = 1
vim.g['airline#extensions#tabline#left_sep'] = ' '
vim.g['airline#extensions#tabline#left_alt_sep'] = '|'
vim.g['airline#extensions#tabline#right_sep'] = ' '
vim.g['airline#extensions#tabline#right_alt_sep'] = '|'
vim.g['airline#extensions#tabline#show_buffers'] = 0
vim.g.airline_exclude_preview = 1

--- vim-go
vim.g.go_fmt_fail_silently = 0

--- vim-rust
vim.g.rustfmt_autosave = 1

--- Splits open on bottom and right
vim.opt.splitbelow = true
vim.opt.splitright = true

--- Indentations
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

--- Strip whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = [[%s/\s\+$//e]]
})

--- Look
vim.opt.guifont = 'Inconsolata-dz for Powerline:h13'
vim.g.tmuxline_powerline_separators = 0

-- Set leader key to space
vim.g.mapleader = ' '

--- Mappings
-- gsub string that's under cursor
vim.keymap.set('n', '<Leader>s', ':%s/\\<<C-r><C-w>\\>/', { noremap = true })

-- space to unhighlight searches
vim.keymap.set('n', '<Space>', ':nohlsearch<Bar>:echo<CR>', { noremap = true, silent = true })

-- Toggle line numbers
vim.keymap.set('n', '<F2>', ':set nonumber!<CR>', { noremap = true })

-- Quick save and quit
vim.keymap.set('n', ',s', ':w<CR>', { noremap = true })
vim.keymap.set('n', ',q', ':wq<CR>', { noremap = true })

-- Edit file in current directory
vim.keymap.set('n', '<Leader>e', ':e <C-R>=expand("%:p:h") . "/"<CR>', { noremap = true })

-- Vertical split in current directory
vim.keymap.set('n', '<Leader>v', ':vsp <C-R>=expand("%:p:h") . "/"<CR>', { noremap = true })

-- Horizontal split in current directory
vim.keymap.set('n', '<Leader>p', ':sp <C-R>=expand("%:p:h") . "/"<CR>', { noremap = true })

-- Use system clipboard (Arch)
vim.opt.clipboard = 'unnamedplus'
-- Yank to system clipboard
vim.keymap.set('', '<Leader>c', '"+y', { noremap = true })

--- vim-test mappings
vim.keymap.set('n', '<leader>n', ':TestNearest<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>t', ':TestFile<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>a', ':TestSuite<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>l', ':TestLast<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>g', ':TestVisit<CR>', { noremap = true, silent = true })

