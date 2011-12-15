filetype on
filetype plugin on
syntax on

" turn off annoying bracket matcher
let loaded_matchparen=1

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

nmap \ :noh
nmap = za
nmap - zc
map ,p <Esc>:set paste<CR>

au BufRead,BufNewFile *.json set filetype=json
"au! Syntax json source /Users/oldbrad/.vim/ftplugin/json.vim

" Pretty color schemes with iTerm2
" From: http://kevin.colyar.net/2011/01/pretty-vim-color-schemes-in-iterm2/
set t_Co=256
colorscheme desert256 
