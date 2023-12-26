" Vim Config!
"
" Now with vim-plug support.
" https://github.com/junegunn/vim-plug
"
" Plugin configs at the BOTTOM of this file.

filetype on
filetype plugin on
syntax on

" turn off annoying bracket matcher
let loaded_matchparen=1
let mapleader=","
set autoindent
set expandtab
set foldmethod=indent
set foldlevel=99
set nocompatible
set report=0
set shiftwidth=4
set showmatch
set tabstop=4
set nu
set nospell
set ruler
set encoding=utf-8

" Activate the following to display tabs/newlines in code.
set list
set listchars=tab:>-
"set listchars=eol:¬,tab:▸-

imap jk <Esc>
nmap \ :noh
nmap = za
nmap - zc
map ,p <Esc>:set paste<CR>
map ,[ <Esc>:set nopaste<CR>
map ,m <Esc>:NERDTreeMirror<CR>
nnoremap <space> za

" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Pretty color schemes with iTerm2
" From: http://kevin.colyar.net/2011/01/pretty-vim-color-schemes-in-iterm2/
set t_Co=256
colorscheme desert256

" Custom color for a popup menu
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#ffffff guibg=#888888

" File-typ handling.
au BufRead,BufNewFile *.py let python_highlight_all=1
au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.html set filetype=htmldjango
au BufRead,BufNewFile *.ejs set filetype=html
au BufRead,BufNewFile *.md set filetype=mkd
au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.less set filetype=less

" File-specific indentation rules
" From: http://vim.wikia.com/wiki/Indenting_source_code
autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType cucumber setlocal shiftwidth=2 tabstop=2
autocmd FileType less setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType sql setlocal shiftwidth=2 tabstop=2

" Ingore things we dont' want to open in vim.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc " MacOSX/Linux

" Ruby syntax checking
"autocmd FileType ruby map <F8> :w<CR>:!ruby -c %<CR>

" Automatically remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Run gofmt
autocmd BufWritePre *.go GoFmt

" Highlight text whose length is over 100 columns
set colorcolumn=120 "bright vertical red line at col 100
highlight ColorColumn ctermbg=darkred guibg=#330000
highlight OverLength ctermbg=17 ctermfg=white guibg=#592929
match OverLength /\%121v.\+/

" Hack to change quickfix color?
" https://stackoverflow.com/a/13228249/182778
highlight BlueLine guibg=Blue
autocmd BufReadPost quickfix match BlueLine /\%1l/
autocmd BufReadPost quickfix nnoremap <buffer> <CR> :execute 'match BlueLine /\%' . line('.') . 'l/'<CR><CR>

" Turn off bells
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=

" --------------------------------------
"
"  Plug(ins) below.
"
"  For Plug commands, see:
"  https://github.com/junegunn/vim-plug#commands
"
" --------------------------------------
call plug#begin()

Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'kien/ctrlp.vim'
"Plug 'scrooloose/syntastic'

Plug 'psf/black', { 'branch': 'stable' }
Plug 'nvie/vim-flake8'
Plug 'fisadev/vim-isort'

call plug#end()

" ---- Plugin Configurations ------------------------

" Syntastic. https://github.com/scrooloose/syntastic
"let g:syntastic_lua_checkers=['luac']
"let g:syntastic_javascript_checkers=['eslint']
"let g:syntastic_javascript_checkers=['jshint']

" NERDCommenter: https://github.com/preservim/nerdcommenter
" no extra config enabled

" NERDTree: https://github.com/preservim/nerdtree
" NERDtree tweeks (The first 3 lines will auto-start NERDTree)
autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" Quit if NERDTree is the only buffer open, see: https://github.com/scrooloose/nerdtree/issues/21
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '__pycache__']

" Ctrl-P
" https://github.com/kien/ctrlp.vim
" Use current directory as the CtrlP working directory
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)|env$'

" Flake8 settings: Hit F8 to run flake8
let g:flake8_cmd="flake8"
autocmd FileType python map <buffer> <F8> :call Flake8()<CR>
autocmd BufWritePre *.py Flake8

" vim-isort -- https://github.com/fisadev/vim-isort
let g:vim_isort_map = ''  " no command, only on save
let g:vim_isort_python_version = 'python3'
autocmd BufWritePre *.py Isort

" Black -- Hit F9 to run & run on save
" See editor integration docs:
" https://black.readthedocs.io/en/stable/integrations/editors.html#vim
let g:black_skip_string_normalization=0
let g:black_linelength=100
let g:black_quiet=0
noremap <F9> :Black<CR>
autocmd BufWritePre *.py execute ':Black'

