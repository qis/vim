" Keymaps
if exists('g:loaded_keymaps')
    finish
endif

let g:loaded_keymaps = 1
let s:save_cpo = &cpo
set cpo&vim

" See lua/keymaps.lua for nvim keymaps.
"
" n - NORMAL
" i - INSERT
" v - VISUAL
" x - VISUAL BLOCK
" c - COMMAND
" t - TERMINAL
"

" Settings
set backspace=indent,eol,start
set clipboard=unnamedplus
set iskeyword+=-
set pastetoggle=<C-p>
set nopaste

let mapleader = '\'
let maplocalleader = '\'

" Copy character with "C" or "CTRL+C".
nnoremap <silent> c vy
nnoremap <silent> <C-c> vy

" Copy selection with "C" or "CTRL+C".
vnoremap <silent> c y
vnoremap <silent> <C-c> y

" Paste with "Insert" or "SHIFT+Insert".
inoremap <silent> <Insert> <C-p><C-r>+<C-p>
inoremap <silent> <S-Insert> <C-p><C-r>+<C-p>
nnoremap <silent> <Insert> p
nnoremap <silent> <S-Insert> p
vnoremap <silent> <Insert> p
vnoremap <silent> <S-Insert> p
cnoremap <Insert> <C-r>+
cnoremap <S-Insert> <C-r>+

" Redo with "R" or "CTRL+R".
nnoremap <silent> r <C-r>

" Write with "CTRL+S".
inoremap <silent> <C-s> <C-o>:w<CR>
nnoremap <silent> <C-s> :w<CR>

" Clear search with "CTRL+L".
inoremap <silent> <C-l> <C-o>:noh<CR>

" Delete word with "CTRL+Backspace".
inoremap <silent> <C-Backspace> <C-w>

" Delete word with "CTRL+Del".
inoremap <silent> <C-Del> <C-o>dw

" Move to the beginning of a function with "CTRL+Up".
inoremap <silent> <C-Up> <C-o>[[
nnoremap <silent> <C-Up> [[

" Move to the end of a function with "CTRL+Down".
inoremap <silent> <C-Down> <C-o>][
nnoremap <silent> <C-Down> ][

" Change indentation of selection with "<" and ">".
vnoremap <silent> < <gv<CR>
vnoremap <silent> > >gv<CR>

" Toogle comment on line/selection with "LEADER \".
nnoremap <silent> <Leader>\ <Plug>CommentaryLine
vnoremap <silent> <Leader>\ <Plug>Commentary
xnoremap <silent> <Leader>\ <Plug>Commentary

" Move to first character or line start with "Home".
inoremap <silent> <Home> <C-o>:call CoreHome()<CR>
nnoremap <silent> <Home> :call CoreHome()<CR>

" Move text up with "ALT+Up".
nnoremap <silent> <A-Up> :m .-2<CR>==
vnoremap <silent> <A-Up> :m .-2<CR>==
xnoremap <silent> <A-Up> :move '<-2<CR>gv-gv

" Move text down with "ALT+Down".
nnoremap <silent> <A-Down> :m .+1<CR>==
vnoremap <silent> <A-Down> :m .+1<CR>==
xnoremap <silent> <A-Down> :move '>+1<CR>gv-gv

" Write buffer or tab with "LEADER W".
nnoremap <silent> <Leader>w :w<CR>

" Git: Show [G]it [B]lame.
nnoremap <silent> <Leader>gb :Git blame<CR>

if !has('nvim')
  " Close buffer or tab with "LEADER Q".
  nnoremap <Leader>q :q<CR>

  " Force close buffer or tab with "LEADER X".
  nnoremap <Leader>x :q!<CR>
endif

let &cpo = s:save_cpo
unlet s:save_cpo
