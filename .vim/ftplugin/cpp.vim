" highlight characters after column 80
hi TooManyChars guifg=White guibg=Red ctermfg=White ctermbg=Red
match TooManyChars /\%>80v.\+/

" command to turn off 80 character line limit
command! No80 :hi TooManyChars NONE

" When using C++, use these to quickly switch between .h and .cc files
command! Toh :e %:r.h
command! Toc :e %:r.cc
