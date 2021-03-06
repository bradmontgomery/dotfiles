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
"set list
"set listchars=tab:>-
"set listchars=eol:¬,tab:▸-

"set guifont=Monaco:h13
"set guifont=Ubuntu\ Mono:h18
set guifont=Anonymous\ Pro:h16

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

au BufRead,BufNewFile *.py let python_highlight_all=1
au BufRead,BufNewFile *.go set filetype=go
au BufRead,BufNewFile *.html set filetype=htmldjango
au BufRead,BufNewFile *.ejs set filetype=html
au BufRead,BufNewFile *.md set filetype=mkd
au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.less set filetype=less

" Pretty color schemes with iTerm2
" From: http://kevin.colyar.net/2011/01/pretty-vim-color-schemes-in-iterm2/
set t_Co=256
colorscheme desert256

" Custom color for a popup menu
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#ffffff guibg=#888888

" File-specific indentation rules
" From: http://vim.wikia.com/wiki/Indenting_source_code
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType cucumber setlocal shiftwidth=2 tabstop=2
autocmd FileType less setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType sql setlocal shiftwidth=2 tabstop=2

" Pathogen: https://github.com/tpope/vim-pathogen
call pathogen#infect()

" NERDtree tweeks (The first 3 lines will auto-start NERDTree)
"autocmd vimenter * NERDTree
"autocmd vimenter * if !argc() | NERDTree | endif
" Quit if NERDTree is the only buffer open, see: https://github.com/scrooloose/nerdtree/issues/21
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '__pycache__']

" Use current directory as the CtrlP working directory
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)|env$'

" Ingore things we dont' want to open in vim.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc " MacOSX/Linux

" Flake8 settings
autocmd FileType python map <buffer> <F8> :call Flake8()<CR>
let g:flake8_cmd="flake8"

" Black settings. See editor integration docs:
" https://github.com/psf/black/blob/master/docs/editor_integration.md#vim
autocmd BufWritePre *.py execute ':Black'
noremap <F9> :Black<CR>
let g:black_fast=0
let g:black_linelength=88
let g:black_skip_string_normalization=0
let g:black_virtualenv="~/.vim/black"

" Ruby syntax checking
autocmd FileType ruby map <F8> :w<CR>:!ruby -c %<CR>

" Automatically remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Run gofmt
autocmd BufWritePre *.go GoFmt

" Syntastic. https://github.com/scrooloose/syntastic
let g:syntastic_lua_checkers=['luac']
"let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_javascript_checkers=['eslint']
let coffee_linter = '/usr/local/bin/coffeelint'


" Highlight text whose length is over 80 columns
set colorcolumn=80 "bright vertical red line at col 80
highlight ColorColumn ctermbg=darkred guibg=#330000 "sets column color
highlight OverLength ctermbg=17 ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

" Hack to change quickfix color?
" https://stackoverflow.com/a/13228249/182778
highlight BlueLine guibg=Blue
autocmd BufReadPost quickfix match BlueLine /\%1l/
autocmd BufReadPost quickfix nnoremap <buffer> <CR> :execute 'match BlueLine /\%' . line('.') . 'l/'<CR><CR>

" Highlight search strings
"set :hls

" ---------- GVim Settings ---------------------------------
" Shamelessly stolen from:
" https://github.com/dpritchett/dotfiles/blob/master/.gvimrc
" ----------------------------------------------------------
" Don't intercept Cmd-P or Cmd-W
"macmenu File.Print  key=<nop>
"macmenu File.Close  key=<nop>
" Stop hitting cmd-w
nnoremap <D-w> <Nop>
inoremap <D-w> <Nop>

" Hide toolbar
set guioptions-=T
" Turn off bells
set noerrorbells
set novisualbell
set t_vb=
autocmd! GUIEnter * set vb t_vb=
