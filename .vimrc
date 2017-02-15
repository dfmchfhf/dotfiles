set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

if has('mouse')
  set mouse=a
endif
if has('gui_running')
  set guifont=Tamsyn7x13
  set lines=54 columns=160
endif
set backspace=indent,eol,start
set shellslash
filetype plugin on
let g:tex_flavor='latex'

highlight link EoLWS ErrorMsg
"au InsertEnter * match EoLWS /\s\+\%#\@<!$/
"au InsertLeave * match EoLWS /\s\+$/
match EoLWS /\s\+$/

syntax on

set laststatus=2
set statusline=%2n:%m%y%w%<%f%=%4b/%04B\ \ %4l,%-7(%c%V%)\ \ %P
set history=1000
set number
set wildmode=list:longest
set listchars=eol:$,tab:>.,extends:\\,precedes:\\
set nowrap
set scrolloff=3
set sidescrolloff=6
set sidescroll=1
set autoindent
set tabstop=2
set expandtab
set hlsearch
set incsearch

nmap <F2> :ls<CR>:bu!<space>

colorscheme mine

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
