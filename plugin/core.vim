" Core
if exists('g:loaded_core')
    finish
endif

let g:loaded_core = 1
let s:save_cpo = &cpo
set cpo&vim

" Status Line
hi! link StatusMode StatusNormalBold
hi! link StatusData StatusNormal

let s:visual_block_mode_return_value = nr2char(22)

function! StatusMode() abort
  let m = mode()
  if m ==# 'n'
    hi! link StatusMode StatusNormalBold
    hi! link StatusData StatusNormal
    return 'NORMAL'
  elseif m ==? 'v'
    hi! link StatusMode StatusVisualBold
    hi! link StatusData StatusVisual
    return 'VISUAL'
  elseif m ==# s:visual_block_mode_return_value
    hi! link StatusMode StatusVisualBold
    hi! link StatusData StatusVisual
    return 'VISUAL (BLOCK)'
  elseif m ==# 'i'
    hi! link StatusMode StatusInsertBold
    hi! link StatusData StatusInsert
    return 'INSERT'
  elseif m ==# 'R'
    hi! link StatusMode StatusReplaceBold
    hi! link StatusData StatusReplace
    return 'REPLACE'
  elseif m ==? 's'
    hi! link StatusMode StatusVisualBold
    hi! link StatusData StatusVisual
    return 'SELECT'
  elseif m ==# 't'
    hi! link StatusMode StatusInsertBold
    hi! link StatusData StatusInsert
    return 'TERMINAL'
  elseif m ==# 'c'
    hi! link StatusMode StatusNormalBold
    hi! link StatusData StatusNormal
    return 'COMMAND'
  elseif m ==# '!'
    hi! link StatusMode StatusReplaceBold
    hi! link StatusData StatusReplace
    return 'SHELL'
  else
    return '[' . m . ']'
  endif
endfunction

function! StatusHead() abort
  let s = ''
  if has('nvim')
    let s = get(b:, 'gitsigns_head', '')
  else
    let s = FugitiveStatusline()
  endif
  return empty(s) ? "\u2262" : "\u2261 " . s  " ≢ ≡
endfunction

function! StatusFileReadonly() abort
  return &readonly ? "\u203C" : ''  " ‼
endfunction

function! StatusFormat() abort
  let s = ''
  if &fenc != 'utf-8'
    let s .= '[' . &fenc . ']'
  endif
  if &ff != 'unix'
    let s .= '[' . &ff . ']'
  endif
  if exists('+bomb') && &bomb
    let s .= '[bom]'
  endif
  return s
endfunction

function! StatusType() abort
  return &ft
endfunction

function! StatusData() abort
  let m = line('$')
  let s = printf('%3d/%d ', line('.'), m)
  if m < 100
    let s .= m < 10 ? '  ' : ' '
  endif
  return s . "\u00B6" . printf(' %3d', virtcol('.'))  " ¶
endfunction

set statusline=
set statusline+=%#StatusMode#\ %{StatusMode()}\                   " mode
set statusline+=%#StatusInfo#\ %{StatusHead()}\                   " head
set statusline+=%#StatusFile#\ %f%m                               " file
set statusline+=%#StatusFileReadonly#\ %{StatusFileReadonly()}%=  " file readonly
set statusline+=%#StatusFile#\ [0x%B]%{StatusFormat()}\           " file format
set statusline+=%#StatusInfo#\ %{StatusType()}\                   " file type
set statusline+=%#StatusData#\ %{StatusData()}\                   " data
set laststatus=2

" Mode Line
set nomodeline

" Match Trailing Whitespace
function! MatchTrailingWhitespace() abort
  if &ft !~ '^\(dap-float\|lspinfo\|qf\|Telescope.*\)$'
    match Visual /\s\+$/
  else
    call clearmatches()
  endif
endfunction

autocmd InsertEnter * call clearmatches()
autocmd InsertLeave,BufEnter,Filetype * call MatchTrailingWhitespace()

" Home
function CoreHome()
  let column = col('.')
  normal! ^
  if column == col('.')
    normal! 0
  endif
endfunction

" Buffer
autocmd BufEnter * :silent! syntax sync fromstart

" File Type
autocmd BufRead,BufNewFile *.json :silent! set filetype=jsonc

" File Type Settings
autocmd FileType make,changelog :silent! set noexpandtab

" Commentary
autocmd FileType c,cpp,javascript,json,jsonc,typescript set commentstring=//%s
autocmd FileType asm,ini set commentstring=;%s
autocmd FileType cmake,yaml set commentstring=#%s
autocmd FileType lua set commentstring=--%s
autocmd FileType vim set commentstring=\"%s

" Clang-Format
let g:clang_format#enable_fallback_style = 0
let g:clang_format#command = exepath(expand("$ACE/bin/clang-format"))
if empty(g:clang_format#command)
  let g:clang_format#command = "clang-format"
endif

" Markdown
let g:markdown_minlines = 128
let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = [
  \ 'asm',
  \ 'bind',
  \ 'bindzone',
  \ 'c',
  \ 'cmake',
  \ 'cmd=dosbatch',
  \ 'conf=sh',
  \ 'cpp',
  \ 'css',
  \ 'dhcpd',
  \ 'diff',
  \ 'fstab',
  \ 'html',
  \ 'ini=dosini',
  \ 'json=jsonc',
  \ 'json5=jsonc',
  \ 'make',
  \ 'makefile=make',
  \ 'manifest=xml',
  \ 'network=networkd',
  \ 'networkd',
  \ 'nft=nftables',
  \ 'nginx',
  \ 'ntp',
  \ 'patch=diff',
  \ 'ps=ps1',
  \ 'ps1',
  \ 'rc',
  \ 'sh',
  \ 'sql',
  \ 'sudoers',
  \ 'system=systemd',
  \ 'systemd',
  \ 'xml',
  \ 'yaml',
  \]

let &cpo = s:save_cpo
unlet s:save_cpo
