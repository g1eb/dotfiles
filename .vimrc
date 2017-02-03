set ic
set ruler
set number
set relativenumber
set hlsearch
set expandtab
set tabstop=2
set shiftwidth=2
set path=$PWD/**
set background=dark

nnoremap ; :
syntax on
filetype plugin indent on
colorscheme Tomorrow-Night

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match TrailingWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Paste buffer to sprunge
:command! Sprunge :!cat % | curl -F 'sprunge=<-' http://sprunge.us

" Run ctags and store tags in git folder
:command! Retag :!ctags --tag-relative --extra=+f -Rf .git/tags --exclude=.git --exclude=*.min.* --languages=-html,sql
set tags+=.git/tags

" Add pathogen to runtime path
execute pathogen#infect()
