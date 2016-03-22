"Bundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=/Users/user/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/Users/user/.vim/bundle/neobundle.vim/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'fatih/vim-go'
NeoBundle 'isRuslan/vim-es6'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'tpope/vim-rails.git'
NeoBundle 'tpope/vim-surround'
NeoBundle 'bling/vim-airline'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'kien/rainbow_parentheses.vim'

" Required:
call neobundle#end()

" Required:
syntax on
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

""" general things
set backspace=indent,eol,start
set nowrap
set autoread
set history=1000
set swapfile
set dir=/tmp

""" disable folding
let g:vim_markdown_folding_disabled=1

""" line numbers
set number

""" colors
set t_Co=256
set background=dark
colorscheme Tomorrow-Night

""" tab complete
set wildmenu
set wildmode=list:longest,full

""" syntastic
let g:syntastic_disabled_filetypes = ['scss', 'sass', 'hbs', 'handlebars.html']

""" statuslines
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extensions#tabline#right_sep=' '
let g:airline#extensions#tabline#right_alt_sep='|'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_exclude_preview = 1

""" jsx specific
let g:jsx_ext_required = 0

""" vim-go
let g:go_fmt_fail_silently = 1

""" splits open on bottom and right
set splitbelow
set splitright

""" Indentations
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

""" Mappings
imap jj <Esc>
imap jk <Esc>
imap kj <Esc>
nnoremap <F2> :set nonumber! <CR>

""" Edit file in current low level directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

""" vsp in current low level directory
nnoremap <Leader>v :vsp <C-R>=expand('%:p:h') . '/'<CR>

""" sp in current low level directory
nnoremap <Leader>p :sp <C-R>=expand('%:p:h') . '/'<CR>

""" Strip whitespace
autocmd BufWritePre * :%s/\s\+$//e

""" look
set hlsearch
set guifont=Inconsolata-dz\ for\ Powerline:h13
let g:tmuxline_powerline_separators = 0

""" mappings
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
