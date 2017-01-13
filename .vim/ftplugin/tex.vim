" =============== LATEX CONFIGURATION ===========================
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" Viewing options
let g:Tex_ViewRule_ps = 'skim'
let g:Tex_ViewRule_pdf = 'skim'
let g:Tex_ViewRule_dvi = 'skim'

" Don't automatically remove indentation when closing brackets/braces
let g:tex_indent_brace = 0

let g:Tex_GotoError = 1

" Vim conceal feature
let g:tex_conceal = "a"

" Latex-box settings
let g:LatexBox_Folding = 0 " folding
let g:LatexBox_fold_automatic = 0 " automatically recalculating folds is slow
" let g:vimtex_toc_fold = 1
" let g:vimtex_fold_enabled = 1
" let g:vimtex_fold_manual = 1
" let g:vimtex_delim_toggle_mod_list = [['\left', '\right'], ['\bigl', '\bigr']]

" vimtex compile flag
" let g:vimtex_latexmk_continuous = 0

" vimtex key maps environment settings
imap <buffer> [[     \begin{
imap <buffer> ]]     <Plug>LatexCloseCurEnv
nmap <buffer> <F5>   <Plug>LatexChangeEnv
vmap <buffer> <F7>   <Plug>LatexWrapSelection
vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection
" imap <buffer> ((     \eqref{
" nmap <buffer> <F5>   <plug>(vimtex-delim-toggle-modifier)
" vmap <buffer> <F7>   <plug>(vimtex-env-change)
