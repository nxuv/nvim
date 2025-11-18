" if g:vim_distro == "despair.nvim"
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter *
    \ if getwininfo()[0]["terminal"] && getwininfo()[0]["quickfix"] |
    \   match ExtraWhitespace /\s\+$/ |
    \ endif
autocmd InsertEnter *
    \ if getwininfo()[0]["terminal"] && getwininfo()[0]["quickfix"] |
    \   match ExtraWhitespace /\s\+\%#\@<!$/ |
    \ endif
autocmd InsertLeave *
    \ if getwininfo()[0]["terminal"] && getwininfo()[0]["quickfix"] |
    \   match ExtraWhitespace /\s\+$/ |
    \ endif
autocmd BufWinLeave * call clearmatches()

command StripWhitespace :%s/\s\+$//
" endif

