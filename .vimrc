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
set nowritebackup
set noswapfile
set nobackup

nnoremap ; :
vnoremap '' xi''<Esc>""P
nnoremap '' ciw''<Esc>""P
vnoremap `` xi``<Esc>""P
nnoremap `` ciw``<Esc>""P
nnoremap \\ ciw['']<Esc>h""P
nnoremap // I//<Esc>

" Clear search highlights
nnoremap ,/ :nohlsearch<CR>

" Move through wrapped lines
nnoremap j gj
nnoremap k gk

" Map § key to <Esc>
cnoremap § <Esc>
inoremap § <Esc>
vnoremap § <Esc>

syntax on
filetype plugin indent on

" Remove trailing space on write
autocmd BufWritePre * :%s/\s\+$//e

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

" Paste buffer to vpaste
command! Vpaste exe ":!cat % | curl -s -F 'text=<-' http://vpaste.net | awk '{print $1}'"

" Run ctags and store tags in git folder
command! Retag :!ctags --tag-relative --extra=+f -Rf .git/tags --exclude=.git --exclude=*.min.* --languages=-javascript,html,sql
set tags+=.git/tags

" Exclude folders when indexing with ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|bower_components\|lib\|git'

" Toggle Vexplore with §§
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
let g:netrw_list_hide= '.*\.swp$'
let g:netrw_browse_split = 4
let g:netrw_liststyle=3
let g:netrw_altv = 1
map <silent> §§ :call ToggleVExplorer()<CR>

" Add pathogen to runtime path
runtime! autoload/pathogen.vim
if exists("*pathogen#infect")
  execute pathogen#infect()
endif
