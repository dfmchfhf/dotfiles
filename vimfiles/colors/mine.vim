highlight clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "custom"

"  0 Black     8
"  1 Blue      9
"  2 Green     10
"  3 Cyan      11
"  4 Red       12
"  5 Magenta   13
"  6 Yellow    14
"  7 LightGrey 15
highlight Normal        ctermfg=10 ctermbg=0  guifg=#A8FF00 guibg=#000000
highlight ErrorMsg      ctermfg=15 ctermbg=4  guifg=#FFFFFF guibg=#FF0000
highlight LineNr        ctermfg=14 ctermbg=8  guifg=#FFFF00 guibg=#333333
highlight StatusLine    cterm=bold,reverse    gui=bold,reverse

" !Red - error
"  Orange - preproc
" !Yellow - symbols
"  Lime - types
" !Green - classes
"  Turquoise - functions
" !Cyan - pseudofunctions
"  Aqua - identifiers
" !Blue - variables
"  Purple - fields, members
" !Magenta - constants
"  Violet - strings


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
"  Violet    - 


highlight Constant      ctermfg=13            guifg=#A000A0 guibg=#350035
highlight String        ctermfg=13            guifg=#FF0080 guibg=#350035
highlight Character     ctermfg=13            guifg=#FF0040 guibg=#350035
highlight Comment       ctermfg=8             guifg=#00A000 guibg=#353535
highlight Number        ctermfg=13            guifg=#FF00FF guibg=#350035
highlight Statement     ctermfg=11            guifg=#00FFFF guibg=#003535
highlight Type          ctermfg=10            guifg=#00FF00 guibg=#002C00 gui=none
highlight PreProc       ctermfg=6             guifg=#FF8000 guibg=#351A00
highlight Identifier    ctermfg=11            guifg=#0080FF guibg=#001A35
highlight Function      ctermfg=11            guifg=#00FF80 guibg=#00351A
highlight Special       ctermfg=13            guifg=#FF2080 guibg=#350035

match EoLWS /\s\+$/
