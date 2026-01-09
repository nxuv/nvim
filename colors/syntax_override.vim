" === Highlight ===
" General
hi! link @variable                Normal
hi! link @lsp.type.keyword        Type
hi! link @keyword.type            Type
hi! link @keyword.modifier        Statement
hi! link @keyword.return          Statement
hi! link @keyword.repeat          Statement
hi! link @keyword.import          Statement
hi! link @keyword.conditional     Statement
hi! link @keyword.operator        Statement
hi! link @keyword.function        Statement
" Todos
hi! link TodoFgWARN               Normal
hi! link TodoFgTODO               Normal
hi! link TodoFgTEST               Normal
hi! link TodoFgPERF               Normal
hi! link TodoFgNOTE               Normal
hi! link TodoFgLINK               Normal
hi! link TodoFgHACK               Normal
hi! link TodoFgFIX                Normal
" CMP
hi! link CmpItemAbbr              Normal
hi! link CmpItemAbbrMatch         Number
hi! link CmpItemAbbrMatchFuzzy    Statement
hi! link CmpItemAbbrDeprecated    Comment
hi! link CmpItemKind              Normal
hi! link CmpItemMenu              CmpItemKind
" Lua TS Keyword
hi! link @keyword.conditional.lua Statement
hi! link @keyword.function.lua    Statement
hi! link @keyword.lua             Statement
hi! link @keyword.repeat.lua      Statement
hi! link @keyword.return.lua      Statement
hi! link @lsp.type.keyword.lua    Define
hi! link luaError                 Normal
hi! link luaParenError            Normal
" C
hi! link cConditional             Statement
hi! link cDefine                  Define
hi! link cParenError              Normal
hi! link cPreCondit               Define
hi! link cPreConditMatch          Define
hi! link cRepeat                  Statement
hi! link cBlock                   Statement
hi! link cLabel                   Statement
hi! link cStorageClass            Type
" CPP
hi! link @lsp.type.macro.cpp      Constant
hi! link @lsp.type.macro          Constant
"   hi!  link                     @lsp.type.macro.cpp NormalBold
hi! link @lsp.type.macro.c        Constant
"   hi!  link                     @lsp.type.macro.c   NormalBold
" ZSH
hi! link zshCommands              Statement
" D
hi! link @module.d                Normal
hi! link @constant.builtin.d      Constant
hi! link @punctuation.delimiter.d Delimiter
hi! link @type.builtin.d          Type
" To sort
hi! link haxeFunction             Statement
hi! link javaScriptReserved       Type
hi! link javaScriptFunction       Type
"hi! link elinksColorBlack         NormalInvert
hi!      elinksColorBlack         ctermfg=Black       guifg=Black  ctermbg=White guibg=White gui=bold cterm=bold
hi!      elinksColorDarkRed       ctermfg=DarkRed     guifg=DarkRed
hi!      elinksColorDarkGreen     ctermfg=DarkGreen   guifg=DarkGreen
hi!      elinksColorDarkYellow    ctermfg=DarkYellow  guifg=DarkYellow
hi!      elinksColorDarkBlue      ctermfg=DarkBlue    guifg=DarkBlue
hi!      elinksColorDarkMagenta   ctermfg=DarkMagenta guifg=DarkMagenta
hi!      elinksColorDarkCyan      ctermfg=DarkCyan    guifg=DarkCyan
hi!      elinksColorGray          ctermfg=Gray        guifg=Gray
hi!      elinksColorDarkGray      ctermfg=DarkGray    guifg=DarkGray
hi!      elinksColorRed           ctermfg=Red         guifg=Red
hi!      elinksColorGreen         ctermfg=Green       guifg=Green
hi!      elinksColorYellow        ctermfg=Yellow      guifg=Yellow
hi!      elinksColorBlue          ctermfg=Blue        guifg=Blue
hi!      elinksColorMagenta       ctermfg=Magenta     guifg=Magenta
hi!      elinksColorCyan          ctermfg=Cyan        guifg=Cyan
hi!      elinksColorWhite         ctermfg=White       guifg=White ctermbg=Black guibg=Black gui=bold cterm=bold

hi! link perlPOD Comment
hi! link podOrdinary Comment
hi podCommand ctermfg=blue cterm=none guifg=#af8431 gui=none guibg=none
hi podVerbatim ctermfg=blue cterm=none guifg=#50616f gui=none guibg=none
hi podFormat ctermfg=cyan cterm=none guifg=#61837e gui=none guibg=none
hi podCmdText ctermfg=cyan cterm=none guifg=#6d7144 gui=none guibg=none
"hi! link podFormat Normal
