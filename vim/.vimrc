" Vim Config!
"
" Now with vim-plug support.
" https://github.com/junegunn/vim-plug
"
" Plugin configs at the BOTTOM of this file.
"
" To override settings locally, create ~/.vimrc.local
" Examples:
"   let g:nerdtree_auto_open = 1    " Enable NERDTree auto-open on startup
"   colorscheme myscheme            " Use a different color scheme
"   let mapleader = ";"             " Change leader key
"
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
set colorcolumn=120 "bright vertical red line at col 120
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
"  For Plug commands, see: https://github.com/junegunn/vim-plug#commands
"  - :PlugInstall
"  - :PlugUpdate
"  - :PlugUpgrade
"
" --------------------------------------
call plug#begin()

Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
"Plug 'scrooloose/syntastic'
"Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" Python formatting/linting is handled by ruff (called directly, see below).
" Install with: uv tool install ruff
Plug 'l2g/vim-syntax-terraform'

call plug#end()

" ---- Plugin Configurations ------------------------

" vim-airline theme.
"let g:airline_theme='molokai'
let g:airline_theme='distinguished'

" Syntastic configuration (deprecated in favor of language-specific linters)
" Commented out - use flake8, black, and eslint directly instead

" NERDCommenter: https://github.com/preservim/nerdcommenter
" no extra config enabled

" NERDTree: https://github.com/preservim/nerdtree
" Optional: Auto-start NERDTree on vim startup
" To enable this, add to ~/.vimrc.local: let g:nerdtree_auto_open = 1
if get(g:, 'nerdtree_auto_open', 0)
    autocmd vimenter * NERDTree
    autocmd vimenter * if !argc() | NERDTree | endif
endif
" Quit if NERDTree is the only buffer open, see: https://github.com/scrooloose/nerdtree/issues/21
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '__pycache__']

" Ctrl-P
" https://github.com/kien/ctrlp.vim
" Use current directory as the CtrlP working directory
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)|env$'

" Ruff -- replaces black, flake8, and isort
" Install with: uv tool install ruff
" F8 = lint (populates quickfix), F9 = format + fix imports
" Auto-runs format + import-fix on save (in-buffer via stdin/stdout, so
" the save is atomic -- formatted content is what gets written to disk).
function! RuffFormat() abort
    if !executable('ruff') | return | endif
    let l:view = winsaveview()
    let l:filename = expand('%')
    let l:input = join(getline(1, '$'), "\n") . "\n"

    " Fix imports (isort equivalent) via stdin
    let l:stdin_arg = '--stdin-filename ' . shellescape(l:filename)
    let l:output = system('ruff check --select I --fix --quiet ' . l:stdin_arg . ' -', l:input)
    if v:shell_error != 0
        echohl WarningMsg | echo 'ruff check failed; skipping format' | echohl None
        return
    endif

    " Format (black equivalent) via stdin
    let l:output = system('ruff format --quiet ' . l:stdin_arg . ' -', l:output)
    if v:shell_error != 0
        echohl WarningMsg | echo 'ruff format failed' | echohl None
        return
    endif

    " Replace buffer contents only if ruff actually changed something
    let l:lines = split(l:output, "\n", 1)
    if len(l:lines) > 0 && l:lines[-1] ==# ''
        call remove(l:lines, -1)
    endif
    if l:lines !=# getline(1, '$')
        silent! %delete _
        call setline(1, l:lines)
    endif
    call winrestview(l:view)
endfunction

function! RuffCheck() abort
    if !executable('ruff') | return | endif
    cexpr system('ruff check --output-format=concise ' . shellescape(expand('%')))
    copen
endfunction

autocmd FileType python noremap <buffer> <F8> :call RuffCheck()<CR>
autocmd FileType python noremap <buffer> <F9> :call RuffFormat()<CR>
autocmd BufWritePre *.py call RuffFormat()

