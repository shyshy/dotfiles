"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/.dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('tpope/vim-fugitive')
call dein#add('scrooloose/syntastic')
call dein#add('flazz/vim-colorschemes')
call dein#add('mxw/vim-jsx')
call dein#add('pangloss/vim-javascript')
call dein#add('vim-ruby/vim-ruby')
call dein#add('fatih/vim-go')
call dein#add('isRuslan/vim-es6')
call dein#add('plasticboy/vim-markdown')
call dein#add('kchmck/vim-coffee-script')
call dein#add('mustache/vim-mustache-handlebars')
call dein#add('tpope/vim-rails.git')
call dein#add('tpope/vim-surround')
call dein#add('bling/vim-airline')
call dein#add('edkolev/tmuxline.vim')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('kien/rainbow_parentheses.vim')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" Required:
syntax on
filetype plugin indent on

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
let g:syntastic_javascript_checkers = ['eslint']

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

""" jsx specific - uncomment when working with jsx
""" let g:jsx_ext_required = 0

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
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
noremap <space> :

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
