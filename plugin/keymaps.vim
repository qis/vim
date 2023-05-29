" See keymaps.lua for nvim keymaps.
"
" n - NORMAL
" i - INSERT
" v - VISUAL
" x - VISUAL BLOCK
" c - COMMAND
" t - TERMINAL
"

" Keymaps
if exists('g:loaded_keymaps')
  finish
endif

let g:loaded_keymaps = 1
let s:save_cpo = &cpo
set cpo&vim

" Settings
set backspace=indent,eol,start
set clipboard=unnamedplus
set iskeyword+=-
set nopaste

let mapleader = '\'
let maplocalleader = '\'

" Copy character or selection to clipboard.
nnoremap <silent> c vy
vnoremap <silent> c y
xnoremap <silent> c y

nnoremap <silent> <C-c> vy
vnoremap <silent> <C-c> y
xnoremap <silent> <C-c> y

" Paste from clipboard.
set pastetoggle=<C-=>

inoremap <silent> <C-p> <C-=><C-r>+<C-=>
nnoremap <silent> <C-p> p
vnoremap <silent> <C-p> p
xnoremap <silent> <C-p> p
cnoremap <C-p> <C-r>+

inoremap <silent> <S-Insert> <C-=><C-r>+<C-=>
nnoremap <silent> <S-Insert> p
vnoremap <silent> <S-Insert> p
xnoremap <silent> <S-Insert> p
cnoremap <S-Insert> <C-r>+

inoremap <silent> <Insert> <C-=><C-r>+<C-=>
nnoremap <silent> <Insert> p
vnoremap <silent> <Insert> p
xnoremap <silent> <Insert> p
cnoremap <Insert> <C-r>+

" Redo last change.
nnoremap <silent> r <C-r>

" Clear serach.
inoremap <silent> <C-l> <C-o>:noh<CR>

" Delete word after cursor.
inoremap <silent> <C-Del> <C-o>dw

" Delete word before cursor.
inoremap <C-h> <C-w>
cnoremap <C-h> <C-w>
inoremap <silent> <C-Backspace> <C-w>
cnoremap <silent> <C-Backspace> <C-w>

" Move to the beginning of a function.
inoremap <silent> <C-Up> <C-o>[[
nnoremap <silent> <C-Up> [[

" Move to the end of a function.
inoremap <silent> <C-Down> <C-o>][
nnoremap <silent> <C-Down> ][

" Go to the first character or beginning of the line.
inoremap <silent> <Home> <C-o>:call CoreHome()<CR>
nnoremap <silent> <Home> :call CoreHome()<CR>

" Move line or selected lines up.
inoremap <silent> <A-Up> <C-o>:m .-2<CR>
nnoremap <silent> <A-Up> :m .-2<CR>==
vnoremap <silent> <A-Up> :m .-2<CR>==
xnoremap <silent> <A-Up> :move '<-2<CR>gv-gv

" Move line or selected lines down.
inoremap <silent> <A-Down> <C-o>:m .+1<CR>
nnoremap <silent> <A-Down> :m .+1<CR>==
vnoremap <silent> <A-Down> :m .+1<CR>==
xnoremap <silent> <A-Down> :move '>+1<CR>gv-gv

" Move screen one line up.
inoremap <silent> <S-Up> <C-o><C-y>
nnoremap <silent> <S-Up> <C-y>
vnoremap <silent> <S-Up> <C-y>
xnoremap <silent> <S-Up> <C-y>

" Move screen one line down.
inoremap <silent> <S-Down> <C-o><C-e>
nnoremap <silent> <S-Down> <C-e>
vnoremap <silent> <S-Down> <C-e>
xnoremap <silent> <S-Down> <C-e>

" Move screen 1/2 page up.
inoremap <silent> <S-PageUp> <C-o><C-u>
nnoremap <silent> <S-PageUp> <C-u>
vnoremap <silent> <S-PageUp> <C-u>
xnoremap <silent> <S-PageUp> <C-u>

" Move screen 1/2 page down.
inoremap <silent> <S-PageDown> <C-o><C-d>
nnoremap <silent> <S-PageDown> <C-d>
vnoremap <silent> <S-PageDown> <C-d>
xnoremap <silent> <S-PageDown> <C-d>

" Focus next window.
nnoremap <silent> <Tab> <C-w>w
nnoremap <silent> <S-Tab> <C-w>p

" Write buffer.
inoremap <silent> <C-s> <C-o>:w<CR>
nnoremap <silent> <C-s> :w<CR>
nnoremap <silent> <Leader>w :w<CR>

" Simulate nvim buffers mappings.
if !has('nvim')
  " Close window.
  nnoremap <Leader>q :q<CR>

  " Close window (force).
  nnoremap <Leader>x :q!<CR>
endif

" Increase line or selection indentation.
vnoremap <silent> > >gv

" Decrease line or selection indentation.
vnoremap <silent> < <gv

" Toggle comment status of line or block.
nnoremap <silent> <Leader>\ :Commentary<CR>
vnoremap <silent> <Leader>\ :Commentary<CR>
xnoremap <silent> <Leader>\ :Commentary<CR>

" Create command abbreviations.
cnoreabbrev <expr> git ((getcmdtype() is# ':' && getcmdline() is# 'git')?('Git'):('git'))
cnoreabbrev <expr> cmake ((getcmdtype() is# ':' && getcmdline() is# 'cmake')?('CMake'):('cmake'))

" Run clang-format on file or selection.
nnoremap <silent> <Leader>cf :ClangFormat<CR>
vnoremap <silent> <Leader>cf :ClangFormat<CR>

" Toggle git blame view.
nnoremap <silent> <Leader>gb :Git blame<CR>

" Show syntax highlight under cursor.
nnoremap <Leader>. :echo
  \ 'hi[' . synIDattr(synID(line('.'),col('.'),1),'name') . '] ' .
  \ 'tr[' . synIDattr(synID(line('.'),col('.'),0),'name') . '] ' .
  \ 'lo[' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . ']'<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
