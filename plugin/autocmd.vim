" DOES NOT INCLUDE NON-GENERAL OR LUA AUTOCMD'S
" SEARCH FOR nvim_create_autocmd TO FIND OTHERS

augroup HighlightYankedText
    autocmd!
    autocmd TextYankPost * silent! lua vim.hl.on_yank {higroup='Visual', timeout=300}
augroup END

augroup ReloadFileIfChanged
    autocmd!
    " trigger `autoread` when files changes on disk
    "autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
    " notification after file change
    autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

augroup GoToLastEdit
    autocmd!
    autocmd BufReadPost * silent! normal! g`"zv
augroup END

augroup ToggleCursorLine
    autocmd!
    autocmd WinEnter,BufEnter * setlocal cursorline
    autocmd WinLeave,BufLeave * setlocal nocursorline
augroup END

"match ExtraWhitespace /\s\+$/
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
"autocmd InsertLeave * match ExtraWhitespace /\s\+$/
"autocmd BufWinLeave * call clearmatches()

command StripWhitespace :%s/\s\+$//
