" highlight characters after column 80
hi TooManyChars guifg=White guibg=Red ctermfg=White ctermbg=Red
match TooManyChars /\%>80v.\+/

" command to turn off 80 character line limit
command! No80 :hi TooManyChars NONE

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix

nnoremap <silent> <F5> :!clear;python %<CR>
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<CR>
xnoremap <S-F9> <esc>:'<,'>:w !python<CR>
