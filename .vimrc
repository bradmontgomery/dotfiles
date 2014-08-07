filetype on
filetype plugin on
syntax on

" turn off annoying bracket matcher
let loaded_matchparen=1
let mapleader=","
set autoindent
set expandtab
"set foldmethod=marker
set nocompatible
set report=0
set shiftwidth=4
set showmatch
set tabstop=4
set nu
set nospell
set ruler
"set guifont=Monaco:h13
"set guifont=Ubuntu\ Mono:h18
set guifont=Anonymous\ Pro:h16

nmap \ :noh
nmap = za
nmap - zc
map ,p <Esc>:set paste<CR>
map ,[ <Esc>:set nopaste<CR>
map ,m <Esc>:NERDTreeMirror<CR>

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
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$']

" Use current directory as the CtrlP working directory
let g:ctrlp_working_path_mode = 'ra'
" Ingore things we dont' want to open in vim.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc " MacOSX/Linux

" Flake8 settings
autocmd FileType python map <buffer> <F8> :call Flake8()<CR>
let g:flake8_cmd="~/.virtualenvs/flake8/bin/flake8"
" working with legacy python, so ignore:
" - E111 indentation is not a multiple of four errors
" - E121 continuation line indentation is not a multiple of four
" - E123 closing bracket does not match indentation of opening bracket's line
" - E124 closing bracket does not match visual indentation
" - E127 continuation line over-indented for visual indent
" - E128 continuation line under-indented for visual indent
" - E201 whitespace after '('
" - E202 whitespace before ')'
" - E203 whitespace before ':'
" - E221 multiple spaces before operator
" - E225 missing whitespace around operator
" - E226 missing whitespace around arithmetic operator
" - E231 missing whitespace after ','
" - E251 no spaces around keyword / parameter equals
" - E265 block comment should start with '# '"
" - E302 expected 2 blank lines, found 1
" - E303 too many blank lines
" - E501 line too long
" - E711 comparison to None should be 'if cond is not None:'
" - E712 comparison to False should be 'if cond is False:' or 'if not cond:'
"let g:flake8_ignore="E111,E121,E123,E124,E127,E128,E201,E202,E203,E221,E225,E226,E231,E251,E265,E302,E303,E501,E711,E712"
let g:flake8_max_line_length=160

" Ruby syntax checking
autocmd FileType ruby map <F8> :w<CR>:!ruby -c %<CR>

" Automatically remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" Syntastic. https://github.com/scrooloose/syntastic
let g:syntastic_lua_checkers=['luac']
let g:syntastic_javascript_checkers=['jshint']


" Highlight text whose length is over 80 columns
set colorcolumn=80 "bright vertical red line at col 80
highlight ColorColumn ctermbg=darkred guibg=#330000 "sets column color
highlight OverLength ctermbg=17 ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

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
