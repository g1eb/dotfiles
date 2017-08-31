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
set backspace=indent,eol,start

nnoremap ; :
nnoremap '' ciw''<Esc>""P
nnoremap \\ ciw['']<Esc>h""P
inoremap § <Esc>

syntax on
filetype plugin indent on

" Set colorscheme
try
  colorscheme Tomorrow-Night
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
autocmd BufWinEnter * match TrailingWhitespace /\s\+$/
autocmd InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match TrailingWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Move (multiple) lines up with <ctrl+k>
function! s:MoveLinesUp()
  silent exe printf('m .-%d', v:count1+1)
  norm ==
endfunction
nnoremap <silent> <c-k> :<c-u>call <SID>MoveLinesUp()<CR>

" Move (multiple) lines down with <ctrl+j>
function! s:MoveLinesDown()
  silent exe printf('m .+%d', v:count1)
  norm ==
endfunction
nnoremap <silent> <c-j> :<c-u>call <SID>MoveLinesDown()<CR>

" Paste buffer to sprunge
command! Sprunge exe ":!cat % | curl -s -F 'sprunge=<-' http://sprunge.us | awk '{print $1\"?" . expand('%:e') . "\"}'"

" Run ctags and store tags in git folder
command! Retag :!ctags --tag-relative --extra=+f -Rf .git/tags --exclude=.git --exclude=*.min.* --languages=-javascript,html,sql
set tags+=.git/tags

" Exclude folders when indexing with ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|lib\|git'

" Add pathogen to runtime path
runtime! autoload/pathogen.vim
if exists("*pathogen#infect")
  execute pathogen#infect()
endif
