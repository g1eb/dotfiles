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

" Swap lines up/down using ctrl-k/ctrl-j
function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction
function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif

    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction
function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif

    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction
noremap <silent> <c-k> :call <SID>swap_up()<CR>
noremap <silent> <c-j> :call <SID>swap_down()<CR>

" Paste buffer to sprunge
command! Sprunge :!cat % | curl -F 'sprunge=<-' http://sprunge.us

" Run ctags and store tags in git folder
command! Retag :!ctags --tag-relative --extra=+f -Rf .git/tags --exclude=.git --exclude=*.min.* --languages=-javascript,html,sql
set tags+=.git/tags

" Exclude folders when indexing with ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|git'

" Add pathogen to runtime path
runtime! autoload/pathogen.vim
if exists("*pathogen#infect")
  execute pathogen#infect()
endif
