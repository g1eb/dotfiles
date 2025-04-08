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
set cc=80

nnoremap ; :
vnoremap '' xi''<Esc>""P
nnoremap '' ciw''<Esc>""P
vnoremap `` xi``<Esc>""P
nnoremap `` ciw``<Esc>""P
vnoremap \\ xi['']<Esc>h""P
nnoremap \\ ciw['']<Esc>h""P

" Search and replace word under the cursor
nnoremap \s :%s/\<<C-r><C-w>\>/

" Clear search highlights
nnoremap // :nohlsearch<CR>

" Move through wrapped lines
nnoremap j gj
nnoremap k gk

" Map § key to `
cnoremap § `
inoremap § `
vnoremap § `

" Map Shift + § key to ~
cnoremap <S-§> ~
inoremap <S-§> ~
vnoremap <S-§> ~

" Map jj to <Esc> [ipad version of the §] :/
inoremap jj <Esc>

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

" Execute Wq as wq
command! Wq :exec ":wq"

" Execute Tabe as tabe
command! Tabe :exec ":tabe"

" Execute current line in shell
command! RunLine :exec '!'.getline('.')
command! RunFile :.w !bash

" Expand minified json to human-readable form
command! ExpandJSON :exec ":%!python -m json.tool"

" Paste buffer to vpaste
command! Vpaste exe ":!cat % | curl -s -F 'text=<-' http://vpaste.net | awk '{print $1}'"

" Run ctags and store tags in git folder
command! Retag :!ctags --tag-relative --extra=+f -Rf .git/tags --exclude=.git --exclude=*.min.* --languages=-javascript,html,sql
set tags+=.git/tags

" Wrap commit messages after 72 characters
au FileType gitcommit setlocal tw=80

" Add specific comment to disable eslint checking the current line
command! ESLintShush normal! O// eslint-disable-next-line<Esc>j0

" Vimdiff
if &diff
  set diffopt+=iwhite
  set cursorline
  colorscheme Tomorrow-Night
  nnoremap > ]c
  nnoremap < [c
endif

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

" Tweaks for file browsing
let g:netrw_banner = 0 " disable the banner
let g:netrw_list_hide = '.*\.swp$' " hide swap files
let g:netrw_browse_split = 4 " open in prior window
let g:netrw_liststyle = 3 " tree view
let g:netrw_altv = 1 " open splits to the right
map <silent> §§ :call ToggleVExplorer()<CR>

" Add pathogen to runtime path
runtime! autoload/pathogen.vim
if exists("*pathogen#infect")
  execute pathogen#infect()
endif

syntax on
filetype plugin indent on



" Insert a new empty reveal.js slide
command! Slide call InsertNewSlide()
command! NewSlide call InsertNewSlide()

function! InsertNewSlide()
  " Start at current line and search upward for the first non-blank line
  let lnum = prevnonblank(line('.') - 1)
  let l:indent = matchstr(getline(lnum), '^\s*')

  " Get current line for insertion
  let l:line = line('.')

  " Create the slide with the detected indentation
  let l:slide = [
        \ l:indent . '',
        \ l:indent . '<section>',
        \ l:indent . '  <h3></h3>',
        \ l:indent . '  <br />',
        \ l:indent . '',
        \ l:indent . '  <p class="fragment"></p>',
        \ l:indent . '  <p class="fragment"></p>',
        \ l:indent . '  <p class="fragment"></p>',
        \ l:indent . '</section>',
        \ l:indent . ''
        \ ]

  " Insert lines
  call append(l:line - 1, l:slide)

  " Move cursor to <h3> line and jump inside
  call cursor(l:line + 2, 0)
  normal! f>a
endfunction


" Insert a <pre></pre> bit in reveal.js style
command! Pre call InsertPre()

function! InsertPre()
  " Start at current line and search upward for the first non-blank line
  let lnum = prevnonblank(line('.') - 1)
  let l:indent = matchstr(getline(lnum), '^\s*')

  " Get current line for insertion
  let l:line = line('.')

  " Create the slide with the detected indentation
  let l:slide = [
        \ l:indent . '',
        \ l:indent . '<pre class="fragment"><code class="hljs python" data-line-numbers data-trim contenteditable>',
        \ l:indent . '',
        \ l:indent . '</code></pre>',
        \ l:indent . ''
        \ ]

  " Insert lines
  call append(l:line - 1, l:slide)

  " Move cursor to <h3> line and jump inside
  call cursor(l:line + 2, 0)
  normal! f>a
endfunction


" Insert a slide with an img tag
command! Img call InsertImg()

function! InsertImg()
  " Start at current line and search upward for the first non-blank line
  let lnum = prevnonblank(line('.') - 1)
  let l:indent = matchstr(getline(lnum), '^\s*')

  " Get current line for insertion
  let l:line = line('.')

  " Create the slide with the detected indentation
  let l:slide = [
        \ l:indent . '',
        \ l:indent . '<section>',
        \ l:indent . '  <h3></h3>',
        \ l:indent . '  <img src="" />',
        \ l:indent . '</section>',
        \ l:indent . ''
        \ ]

  " Insert lines
  call append(l:line - 1, l:slide)

  " Move cursor to <h3> line and jump inside
  call cursor(l:line + 2, 0)
  normal! f>a
endfunction
