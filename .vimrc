" dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/dshy/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/dshy/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-rake')
call dein#add('flazz/vim-colorschemes')
call dein#add('isRuslan/vim-es6')
call dein#add('vim-ruby/vim-ruby')
call dein#add('w0rp/ale')
call dein#add('sunaku/vim-ruby-minitest')
call dein#add('plasticboy/vim-markdown')
call dein#add('kchmck/vim-coffee-script')
call dein#add('mustache/vim-mustache-handlebars')
call dein#add('sheerun/vim-polyglot')
call dein#add('fatih/vim-go')
call dein#add('tpope/vim-rails.git')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-projectionist')
call dein#add('bling/vim-airline')
call dein#add('edkolev/tmuxline.vim')
call dein#add('kien/rainbow_parentheses.vim')
call dein#add('vimwiki/vimwiki')
call dein#add('chemzqm/macdown.vim')
call dein#add('AndrewRadev/ember_tools.vim')
call dein#add('rust-lang/rust.vim')
call dein#add('thoughtbot/vim-rspec')
call dein#add('christoomey/vim-tmux-navigator')
" call dein#add('ruby-formatter/rufo-vim')

" You can specify revision/branch/tag.
" call dein#add('Shougo/deol.nvim', { 'rev': 'd0c5bef' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

""" general things
set backspace=indent,eol,start
set wrap " wraps at end of the character
set linebreak " adjusts wrap to wrap at end of word
set autoread
set history=1000
set swapfile
set dir=/tmp
set scrolloff=6
set mouse=a
set nofixeol

""" searching
set ignorecase " disregard case when searching
set smartcase  " with ignorecase _enabled_ match the case if an upper case character is searched for!
set hlsearch
set incsearch

""" disable folding
let g:vim_markdown_folding_disabled=1

""" line numbers
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

""" colors
set t_Co=256
set background=dark
colorscheme Tomorrow-Night

""" tab complete
set wildmenu
set wildmode=list:longest,full

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

""" vim-go
let g:go_fmt_fail_silently = 0

""" vim-rust
let g:rustfmt_autosave = 1

""" splits open on bottom and right
set splitbelow
set splitright

""" Indentations
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

""" Strip whitespace
autocmd BufWritePre * :%s/\s\+$//e

""" look
set guifont=Inconsolata-dz\ for\ Powerline:h13
let g:tmuxline_powerline_separators = 0

" Remap space to leader, recursive so
let mapleader=" "

" {{{ mappings
" gsub string that's under cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" space to unhighlight searches
nmap <silent> <Space> :nohlsearch<Bar>:echo<CR>""

nnoremap <F2> :set nonumber! <CR>
nnoremap ,s :w<CR>
nnoremap ,q :wq<CR>

" edit file in current level directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" vsp in current level directory
nnoremap <Leader>v :vsp <C-R>=expand('%:p:h') . '/'<CR>

" sp in current level directory
nnoremap <Leader>p :sp <C-R>=expand('%:p:h') . '/'<CR>

" yank paste
noremap <Leader>c "*y

" }}} mappings

" vim-rspec
let g:rspec_runner = "os_x_iterm"
let g:rspec_command = "!bundle exec rspec --format documentation {spec}"
map <Leader>n :call RunNearestSpec()<CR>
map <Leader>t :call RunCurrentSpecFile()<CR>

" auto formatters
let g:ale_linters = { 'go': ['gobuild'] } " go vet is broken: errors don't appear in buffer, use gobuild and let default compiler show errors
let g:ale_fixers = { 'handlebars': ['prettier'], 'javascript': ['prettier'], 'ruby': ['rubocop'], 'typescript': ['prettier'] }
" let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
