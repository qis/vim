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
set pastetoggle=<C-p>
set nopaste

let mapleader = '\'
let maplocalleader = '\'

" Copy character or selection to clipboard.
nnoremap <silent> c vy
nnoremap <silent> <C-c> vy
vnoremap <silent> c y
vnoremap <silent> <C-c> y

" Paste from clipboard.
inoremap <silent> <Insert> <C-p><C-r>+<C-p>
inoremap <silent> <S-Insert> <C-p><C-r>+<C-p>
nnoremap <silent> <Insert> p
nnoremap <silent> <S-Insert> p
vnoremap <silent> <Insert> p
vnoremap <silent> <S-Insert> p
xnoremap <silent> <Insert> p
xnoremap <silent> <S-Insert> p
cnoremap <Insert> <C-r>+
cnoremap <S-Insert> <C-r>+

" Redo last change.
nnoremap <silent> r <C-r>

" Clear serach.
inoremap <silent> <C-l> <C-o>:noh<CR>

" Delete word after cursor.
inoremap <silent> <C-Del> <C-o>dw

" Delete word before cursor.
inoremap <silent> <C-Backspace> <C-w>

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
nnoremap <silent> <A-Up> :m .-2<CR>==
vnoremap <silent> <A-Up> :m .-2<CR>==
xnoremap <silent> <A-Up> :move '<-2<CR>gv-gv

" Move line or selected lines down.
nnoremap <silent> <A-Down> :m .+1<CR>==
vnoremap <silent> <A-Down> :m .+1<CR>==
xnoremap <silent> <A-Down> :move '>+1<CR>gv-gv

" Focus next window.
nnoremap <silent> <Tab> <C-w>w

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

" Execute git command.
cnoreabbrev git Git

" Toggle git blame view.
nnoremap <silent> <Leader>gb :Git blame<CR>

" Show syntax highlight under cursor.
nnoremap <Leader>. :echo
  \ 'hi[' . synIDattr(synID(line('.'),col('.'),1),'name') . '] ' .
  \ 'tr[' . synIDattr(synID(line('.'),col('.'),0),'name') . '] ' .
  \ 'lo[' . synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name') . ']'<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
