" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
let s:dein_base = '/Users/dshy/.cache/dein'

" Set Dein source path (required)
let s:dein_src = '/Users/dshy/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)

" Your plugins go here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-rake')
call dein#add('flazz/vim-colorschemes')
call dein#add('vim-ruby/vim-ruby')
call dein#add('dense-analysis/ale')
call dein#add('sunaku/vim-ruby-minitest')
call dein#add('godlygeek/tabular')
call dein#add('preservim/vim-markdown')
call dein#add('mustache/vim-mustache-handlebars')
call dein#add('sheerun/vim-polyglot')
call dein#add('fatih/vim-go')
call dein#add('tpope/vim-rails.git')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-projectionist')
call dein#add('bling/vim-airline')
call dein#add('edkolev/tmuxline.vim')
call dein#add('kien/rainbow_parentheses.vim')
" call dein#add('vimwiki/vimwiki') this conflicts with copilot and vim-markdown
call dein#add('rust-lang/rust.vim')
call dein#add('vim-test/vim-test')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('ruanyl/vim-gh-line')
call dein#add('ruby-formatter/rufo-vim')
call dein#add('github/copilot.vim')

" Finish Dein initialization (required)
call dein#end()

" comment these in whenever you update plugins from above
" call map(dein#check_clean(), "delete(v:val, 'rf')")
" call dein#recache_runtimepath()

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif

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

" vim-test
nmap <silent> <leader>n :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
" don't use bin/rspec, always use bundle exec
let test#ruby#use_binstubs = 0

" auto formatters
let g:ale_linters = { 'go': ['gobuild'] } " go vet is broken: errors don't appear in buffer, use gobuild and let default compiler show errors
let g:ale_fixers = { 'mustache': ['prettier'], 'javascript': ['prettier'], 'ruby': ['rubocop'], 'typescript': ['prettier'] }
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'

" copilot
let g:copilot_filetypes = {'markdown': v:true}
