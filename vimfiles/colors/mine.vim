highlight clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "mine"

"  0 Black     8
"  1 Red       9
"  2 Green     10
"  3 Yellow    11
"  4 Blue      12
"  5 Magenta   13
"  6 Cyan      14
"  7 LightGrey 15

" gui
if has('gui_running')
  let colors_flavour = "gui"
  highlight Normal        guifg=#A8FF00 guibg=#000000
  highlight ErrorMsg      guifg=#FFFFFF guibg=#FF0000
  highlight LineNr        guifg=#FFFF00 guibg=#333333
  highlight StatusLine                                gui=bold,reverse
  highlight CursorLine                  guibg=#333333
  highlight CursorLineNr  guifg=#FFFF00 guibg=#666666 gui=bold
  highlight CursorColumn                guibg=#1B1B1B
  highlight ColorColumn                 guibg=#FF6666
  highlight Search        guifg=NONE    guibg=NONE    gui=reverse
elseif &t_Co == 256
  let colors_flavour = "256"
  highlight Normal        ctermfg=154 ctermbg=016
  highlight ErrorMsg      ctermfg=231 ctermbg=196
  highlight LineNr        ctermfg=226 ctermbg=236
  highlight StatusLine                            cterm=bold,reverse
  highlight CursorLine                ctermbg=236 cterm=none
  highlight CursorLineNr  ctermfg=226 ctermbg=241 cterm=bold
  highlight CursorColumn              ctermbg=234
  highlight ColorColumn               ctermbg=203
  highlight Search                    ctermbg=none cterm=reverse
else
  let colors_flavour = "16"
  highlight Normal        ctermfg=10 ctermbg=00
  highlight ErrorMsg      ctermfg=15 ctermbg=01
  highlight LineNr        ctermfg=11 ctermbg=08
  highlight StatusLine                          cterm=bold,reverse
  highlight CursorLine                          cterm=underline
  highlight CursorLineNr  ctermfg=06 ctermbg=07
  highlight CursorColumn             ctermbg=08
  highlight ColorColumn              ctermbg=09
  highlight Search                   ctermbg=none cterm=reverse
endif

" diff
if has('gui_running')
elseif &t_Co == 256
  highlight DiffAdd       ctermfg=none ctermbg=022 cterm=none
  highlight DiffChange    ctermfg=none ctermbg=018 cterm=none
  highlight DiffDelete    ctermfg=none ctermbg=124 cterm=none
  highlight DiffText      ctermfg=none ctermbg=196 cterm=none
else
endif

" !Red       - Error
"  Orange    - Preproc
" !Yellow    - Strings
"  Lime      - Constants
" !Green     - Variables, Identifiers
"  Turquoise - Fields / Members
" !Cyan      - Pseudofunctions / Keyword
"  Aqua      - Symbols / Operators
" !Blue      - Functions
"  Purple    - Types
" !Magenta   - Classes / Scope Containers
"  Violet    - Number

" syntax
if has('gui_running')
  highlight PreProc       guifg=#FF8000 guibg=#351A00
  highlight String        guifg=#FFFF00 guibg=#353500
  highlight Character     guifg=#FF8000 guibg=#353500
  highlight Constant      guifg=#A0FF00 guibg=#003500
  highlight Identifier    guifg=#00FF00 guibg=#003500
  highlight Statement     guifg=#00FFFF guibg=#003535
  highlight Function      guifg=#4466FF guibg=#000035
  highlight Type          guifg=#A040FF guibg=#1A0035 gui=none
  highlight Number        guifg=#FF00FF guibg=#350035

  highlight Special       guifg=#FF2080 guibg=#350035
  highlight Comment       guifg=#00A000 guibg=#353535
elseif &t_Co == 256
  highlight PreProc       ctermfg=208 ctermbg=052
  highlight String        ctermfg=226 ctermbg=058
  highlight Character     ctermfg=208 ctermbg=058
  highlight Constant      ctermfg=154 ctermbg=022
  highlight Identifier    ctermfg=046 ctermbg=022
  highlight Statement     ctermfg=051 ctermbg=017
  highlight Function      ctermfg=027 ctermbg=017
  highlight Type          ctermfg=093 ctermbg=017
  highlight Number        ctermfg=201 ctermbg=053

  highlight Special       ctermfg=198 ctermbg=053
  highlight Comment       ctermfg=028 ctermbg=237
else
  highlight PreProc       ctermfg=03
  highlight String        ctermfg=11
  highlight Character     ctermfg=11
  highlight Constant      ctermfg=11
  highlight Identifier    ctermfg=10
  highlight Statement     ctermfg=14
  highlight Function      ctermfg=14
  highlight Type          ctermfg=10
  highlight Number        ctermfg=13

  highlight Special       ctermfg=13
  highlight Comment       ctermfg=08
endif
