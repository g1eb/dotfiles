syntax on

set ic
set ruler
set relativenumber
set hlsearch
set expandtab
set tabstop=2
set shiftwidth=2
set path=$PWD/**
set background=dark
colorscheme Tomorrow-Night

nnoremap ; :

highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match TrailingWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

filetype plugin indent on
execute pathogen#infect()
