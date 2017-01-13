" highlight characters after column 80
hi TooManyChars guifg=White guibg=Red ctermfg=White ctermbg=Red
match TooManyChars /\%>80v.\+/

" command to turn off 80 character line limit
command! No80 :hi TooManyChars NONE

setlocal et
setlocal tabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
