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
