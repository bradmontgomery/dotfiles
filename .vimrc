filetype on
filetype plugin on
syntax on

" turn off annoying bracket matcher
let loaded_matchparen=1
let mapleader=","
set autoindent
set expandtab
set foldmethod=marker
set nocompatible
set report=0
set shiftwidth=4
set showmatch
set tabstop=4
set nu
set nospell
set ruler
"set guifont=Monaco:h13
set guifont=Ubuntu\ Mono:h18

nmap \ :noh
nmap = za
nmap - zc
map ,p <Esc>:set paste<CR>
map ,[ <Esc>:set nopaste<CR>
map ,m <Esc>:NERDTreeMirror<CR>

au BufRead,BufNewFile *.ejs set filetype=html
au BufRead,BufNewFile *.md set filetype=mkd
au BufRead,BufNewFile *.json set filetype=json
au BufNewFile,BufRead *.less set filetype=less

" Pretty color schemes with iTerm2
" From: http://kevin.colyar.net/2011/01/pretty-vim-color-schemes-in-iterm2/
set t_Co=256
colorscheme desert256 

" File-specific indentation rules
" From: http://vim.wikia.com/wiki/Indenting_source_code
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType cucumber setlocal shiftwidth=2 tabstop=2
autocmd FileType less setlocal shiftwidth=2 tabstop=2

" Pathogen: https://github.com/tpope/vim-pathogen
call pathogen#infect()

" NERDtree tweeks
autocmd vimenter * NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$']

" Flake8 settings
autocmd FileType python map <buffer> <F8> :call Flake8()<CR>
let g:flake8_cmd="/Users/brad/.virtualenvs/flake8/bin/flake8"

" Ruby syntax checking
autocmd FileType ruby map <F8> :w<CR>:!ruby -c %<CR>

" Highlight text whose length is over 80 columns
set colorcolumn=80 "bright vertical red line at col 80
highlight ColorColumn ctermbg=darkred guibg=#001100 "sets column color
highlight OverLength ctermbg=17 ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
