" Compatibility
scriptencoding utf-8
set nocompatible

" User Interface
if has("gui_running")
  " Font
  if has("win32")
    set guifont=DejaVu_LGC_Sans_Mono:h9:cANSI:qDRAFT
    set guifontwide=IPAexGothicMono:h11:cANSI:qDRAFT
  else
    set guifont=DejaVu\ Sans\ Mono\ 10
    set guifontwide=IPAexGothicMono\ 12
  endif

  " Controls
  set guioptions=acr

  " Window
  set columns=125 lines=63
  if &diff
    set columns=250
  endif

  " Cursor
  set gcr=n-v:hor10-blinkoff800-blinkon800-blinkwait800
  set gcr=i-r:hor100-ver15-blinkoff800-blinkon800-blinkwait1500

  if !has("win32")
    autocmd GUIEnter * :silent! set vb t_vb=
  endif
elseif !has("nvim") && v:version < 800
  autocmd BufEnter * :silent! redrawstatus
endif

" Colors
syntax on
autocmd BufEnter * :silent! syntax sync fromstart

if !empty($DISPLAY) || has("win32")
  let &t_Co = 256
  let &t_ti = "\e[?1049h"
  let &t_te = "\e[?1049l"
else
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

colorscheme wombat

" Indentation
filetype plugin indent on

" Settings
set encoding=utf-8                " default encoding
set fileformats=unix,dos          " supported line endings
set fileencodings=utf-8,utf-16le  " supported file encodings
set autoread                      " automatically read modified files
set scrolloff=3                   " lines visible when scrolling
set hidden                        " hide abandoned buffer
set ignorecase                    " ignore case when searching
set smartcase                     " ignore case when searching lowercase only
set hlsearch                      " highlight search results
set incsearch                     " show search results while typing
set nolazyredraw                  " don't redraw when executing macros
set magic                         " enable magic regular expressions
set showmatch                     " show matching brackets
set matchtime=0                   " how many 100ms to blink when matching brackets
set wrap                          " wrap text instead of scrolling
set number                        " display line numbers
set history=50                    " command line history
set completeopt-=preview          " insert mode completion
set conceallevel=0                " do not hide concealed text
set concealcursor=inv             " conceal cursor modes
set nofoldenable                  " disable folding
set noeol                         " no newline at the end of a file
set iminsert=0                    " input mode in insert mode
set imsearch=0                    " input mode in search mode

" Autocompletion
set wildcharm=<Tab>

" Indenting
set cino=:0,g0,l1,(s,Ws,ws,j1

" Path
set shellslash
set path+=**

" Tabs
set shiftwidth=2                  " insert shiftwidth spaces instead of a single tab
set softtabstop=2                 " insert number of spaces instead of tabs while editing
set tabstop=8                     " display tabs as tabstop spaces
set smarttab                      " backspace deletes shiftwidth spaces
set expandtab                     " use spaces instead of tabs

" Backup
set nobackup
set nowritebackup
set noswapfile

" Errors
set noerrorbells
set novisualbell
set timeoutlen=500
set ttimeoutlen=50
set t_vb=

" Special Characters
set fillchars+=stl:\ ,stlnc:\
set listchars=tab:»·,extends:»,precedes:«,nbsp:␣
set list

" Mouse
if has("mouse")
  set mouse=a
  set mouseshape=i-r:beam,n:arrow,v:arrow,ve:arrow
endif

" Copy & Paste
set nopaste
if has("win32")
  vmap <C-c> "*y
else
  noremap <C-c> "+y
  noremap <S-Insert> "+p
  inoremap <S-Insert> <C-p><C-r>+<C-p>
  set pastetoggle=<C-p>
  vnoremap s "+ygvs
endif

" Russian
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯХЪ;ABCDEFGHIJKLMNOPQRSTUVWXYZ{},
set langmap+=фисвуапршолдьтщзйкыегмцчняхъ;abcdefghijklmnopqrstuvwxyz[]

map Ж :
map Э "
map ж ;
map э '
map Б <
map Ю >
map б ,
map ю .
map Ё ~
map ё `
map ? /
map , /

cnoreabbrev е t
cnoreabbrev у e
cnoreabbrev щ e
cnoreabbrev ц w
cnoreabbrev й q
cnoreabbrev цф wa
cnoreabbrev цй wq
cnoreabbrev цйф wqa

" Commands
cnoreabbrev o e
cnoreabbrev t tabnew
let mapleader = 'k'

" Redo
nnoremap <silent> r <C-r>

" Clear Search
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

" Home
function Home()
  let column = col(".")
  normal! ^
  if column == col(".")
    normal! 0
  endif
endfunction

noremap <silent> <Home> :call Home()<CR>
inoremap <silent> <Home> <C-o>:call Home()<CR>

" Tabs
noremap <silent> <M-Right> :tabnext<CR>
inoremap <silent> <M-Right> <C-o>:tabnext<CR>
noremap <silent> <M-Left> :tabprev<CR>
inoremap <silent> <M-Left> <C-o>:tabprev<CR>

" Make
set makeprg=make\ --no-print-directory

map <F5> :w<CR>:make run<CR>
imap <F5> <ESC>:w<CR>:make run<CR>

map <F6> :w<CR>:make test<CR>
imap <F6> <ESC>:w<CR>:make test<CR>

map <F7> :w<CR>:make<CR>
imap <F7> <ESC>:w<CR>:make<CR>

" Word
set backspace=eol,start,indent

if has("gui_running")
  imap <C-BS> <C-w>
  inoremap <C-Del> <C-o>dw
endif

" Restore Cursor
if has("win32")
  set viminfo='10,\"100,:20,%,n~/viminfo
else
  set viminfo='10,\"100,:20,%,n~/.viminfo
endif

function! RestoreCursor()
  if line("'\"") > 0
    if line("'\"") <= line("$") | exe "norm '\""
    else | exe "norm $"
    endif
  endif
  redraw!
endfunction

autocmd BufReadPost * :silent! call RestoreCursor()

" File Type
autocmd BufRead,BufNewFile *.json :silent! set filetype=json5

" File Type Settings
autocmd FileType make,changelog :silent! set noexpandtab

" File Browser
set browsedir=current

let g:netrw_menu = 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3

nnoremap <Leader>o :Texplore<CR>:file [files]\ <CR>

" Tab Line
set showtabline=2

" Status Line
set laststatus=2

" Disbale modeline.
set nomodeline

" Plugins
let g:is_kornshell = 1

let g:airline_powerline_fonts = 0
let g:airline_extensions = [ "branch", "tabline" ]
let g:airline_section_z = "%3p%% \u00B6 %3l/%-3L \u039E %3v"

if !exists("g:airline_symbols")
  let g:airline_symbols = {}
endif

let g:airline_symbols.branch = "\u2261"      " ≡
let g:airline_symbols.notexists = " \u2020"  " †
let g:airline_symbols.paste = "\u03C1"       " ρ
let g:airline_symbols.readonly = "\u203C"    " ‼

let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1

let g:markdown_minlines = 128
let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = [
  \"asm",
  \"bind",
  \"bindzone",
  \"c",
  \"cmake",
  \"cmd=dosbatch",
  \"conf=sh",
  \"cpp",
  \"css",
  \"dhcpd",
  \"diff",
  \"fstab",
  \"html",
  \"ini=dosini",
  \"json=json5",
  \"json5=json5",
  \"make",
  \"makefile=make",
  \"manifest=xml",
  \"network=networkd",
  \"networkd",
  \"nft=nftables",
  \"nginx",
  \"ntp",
  \"patch=diff",
  \"ps=ps1",
  \"ps1",
  \"rc",
  \"sh",
  \"sql",
  \"sudoers",
  \"system=systemd",
  \"systemd",
  \"xml",
  \"yaml",
  \]
