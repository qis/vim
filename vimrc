" Options
set nobackup
set conceallevel=0
set fileencoding=utf-8
set hlsearch
set ignorecase
if has('mouse')
  set mouse=a
endif
set number
set numberwidth=4
set pumheight=10
set scrolloff=1
set showmode
set showtabline=1
set smartcase
set smartindent
set splitbelow
set splitright
set noswapfile
set termguicolors
set timeoutlen=1000
set undofile
set updatetime=100
set nowritebackup

" Tabs
set expandtab
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=8

" Special Characters
set fillchars+=stl:\ ,stlnc:\ ,
set listchars=tab:»·,extends:»,precedes:«,nbsp:␣
set list

" Compatibility
scriptencoding utf-8
set nocompatible

" Colors
colorscheme core
syntax enable

" File Browser
set browsedir=current
let g:netrw_menu = 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
