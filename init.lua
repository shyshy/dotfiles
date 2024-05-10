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

-- source my old vimrc
local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)

require("lazy").setup({
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "Shougo/neosnippet.vim",
  "Shougo/neosnippet-snippets",
  "tpope/vim-fugitive",
  "tpope/vim-rake",
  "flazz/vim-colorschemes",
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

-- colorscheme
vim.cmd.colorscheme('Tomorrow-Night')
