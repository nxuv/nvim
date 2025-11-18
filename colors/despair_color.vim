" Name: despair color
" Author: Alisa Lain <al1-ce@null.net>
" Notes: Minimal dark colorscheme kind of based on austere

set background=dark
highlight clear
if exists("syntax on")
    syntax reset
endif

let g:colors_name = "despair colorful"

" Background: dark
" Color: black         #101010 ~
" Color: darkgrey      #252525 ~
" Color: darkstone     #7c7c7c ~
" Color: almostwhite   #b9b9b9 ~
" Color: grey          #8e8e8e ~
" Color: white         #f7f7f7 ~
" Color: beige         #e3e3e3 ~
" Color: red           #ce5252 ~
" color: green         #9ca54e ~
" Color: blue          #5f819d ~
" Color: yellow        #f0c674 ~
" c0  #101010
" c1  #903a3a
" c2  #6d7144
" c3  #af8431
" c4  #50616f
" c5  #92729f
" c6  #61837e
" c7  #b9b9b9
" c8  #8e8e8e
" c9  #ce5252
" c10 #9ca54e
" c11 #f0c674
" c12 #5f819d
" c13 #b48ac4
" c14 #73b8af
" c15 #f7f7f7

" How nvim does it
" hi Normal guifg=#ffffff guibg=#000000 gui=NONE cterm=NONE
" guibg is NONE unless it differs from normal

" TODO: handle all `:h hi` groups and such

" :so $VIMRUNTIME/syntax/hitest.vim

" can set StatusLine's guibg to #252525 to have them pretty and colored
hi Cursor term=reverse cterm=reverse gui=reverse
hi Search term=reverse cterm=reverse gui=reverse

hi Normal          ctermfg=white      cterm=none      guifg=#b9b9b9 gui=none      guibg=#101010
hi NormalBold      ctermfg=white      cterm=bold      guifg=#b9b9b9 gui=bold      guibg=none
hi Comment         ctermfg=darkgray   cterm=none      guifg=#6e6e6e gui=none      guibg=none
hi CursorLine      ctermfg=none       cterm=none      guifg=none    gui=none      guibg=none
hi CursorLineNr    ctermfg=gray       cterm=none      guifg=#f7f7f7 gui=none      guibg=none
hi LineNr          ctermfg=gray       cterm=none      guifg=#b9b9b9 gui=none      guibg=none
hi Number          ctermfg=blue       cterm=none      guifg=#5f819d gui=bold      guibg=none
hi Boolean         ctermfg=blue       cterm=none      guifg=#5f819d gui=bold      guibg=none
hi Operator        ctermfg=white      cterm=bold      guifg=#b9b9b9 gui=bold      guibg=none
hi Pmenu           ctermfg=white      cterm=none      guifg=#b9b9b9 gui=none      guibg=#252525
hi PmenuSbar       ctermfg=white      cterm=none      guifg=#b9b9b9 gui=none      guibg=#252525
hi PmenuSel        ctermfg=white      cterm=bold      guifg=#f7f7f7 gui=bold      guibg=#252525
hi PmenuThumb      ctermfg=white      cterm=none      guifg=#b9b9b9 gui=none      guibg=none
hi SignColumn      ctermfg=darkgray   cterm=none      guifg=#8e8e8e gui=none      guibg=none
hi Special         ctermfg=darkyellow cterm=bold      guifg=#af8431 gui=bold      guibg=none
hi Statement       ctermfg=red        cterm=bold      guifg=#903a3a gui=bold      guibg=none
hi String          ctermfg=darkgreen  cterm=none      guifg=#9ca54e gui=none      guibg=none
hi Type            ctermfg=red        cterm=bold      guifg=#903a3a gui=bold      guibg=none
hi VertSplit       ctermfg=black      cterm=none      guifg=#101010 gui=none      guibg=none
hi VisualNOS       ctermfg=white      cterm=none      guifg=#b9b9b9 gui=none      guibg=#252525
hi ExtraWhitespace ctermfg=red        cterm=underline guifg=#ce5253 gui=underline guibg=#2f1515
hi Error           ctermfg=red        cterm=none      guifg=#101010 gui=none      guibg=#ce5252
hi DiagnosticUnderlineError term=underline ctermfg=none cterm=underline guifg=none gui=underline guibg=none guisp=none
"hi  StatusLine               term=none               ctermfg=white    cterm=underline guifg=#b9b9b9 gui=underline guibg=#101010
"hi  StatusLineNC             term=none               ctermfg=darkgray cterm=underline guifg=#6e6e6e gui=underline guibg=#101010

hi! link DiagnosticUnderlineHint DiagnosticUnderlineError
hi! link DiagnosticUnderlineInfo DiagnosticUnderlineError
hi! link DiagnosticUnderlineOk   DiagnosticUnderlineError
hi! link DiagnosticUnderlineWarn DiagnosticUnderlineError
" hi! link Special                 Normal
" hi! link Statement               Normal
" hi! link Type                    Normal
" hi! link Conditional             Normal
hi! link Character               String
hi! link ColorColumn             Normal
hi! link Conditional             Statement
hi! link Constant                Normal
hi! link CursorColumn            Normal
hi! link Debug                   Normal
hi! link Define                  Special
hi! link Delimiter               Normal
hi! link Directory               Normal
hi! link Exception               Normal
hi! link Float                   Number
hi! link FloatBorder             Normal
hi! link Function                Number
hi! link Identifier              Normal
hi! link Include                 Special
hi! link Keyword                 Normal
" hi! link Keyword                 Type
hi! link Label                   Normal
hi! link Macro                   NormalBold
hi! link MatchParen              Normal
hi! link NormalFloat             Normal
hi! link PreProc                 Normal
hi! link Precondit               Normal
hi! link Question                Number
hi! link Repeat                  Statement
hi! link SpecialChar             Special
hi! link StatusLine              Normal
hi! link StatusLineNC            Normal
hi! link StatusLineTerm          Normal
hi! link StatusLineTermNC        Normal
hi! link StorageClass            Normal
hi! link StorageClass            Type
hi! link Tabline                 Normal
hi! link TablineFill             Normal
hi! link TablineSel              Normal
hi! link Tag                     Normal
hi! link Terminal                Normal
hi! link Title                   Normal
hi! link Todo                    Normal
hi! link Typedef                 Type
hi! link WinSeparator            Comment
hi! link Constant                Number

for path in split(&runtimepath, ",")
    if filereadable(path . "/colors/syntax_override.vim")
        execute "source " . path . "/colors/syntax_override.vim"
    endif
endfor

