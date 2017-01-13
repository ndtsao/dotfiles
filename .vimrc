" ================ VUNDLE CONFIGURATION =====================

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" General
Plugin 'yggdroot/indentline'
Plugin 'LargeFile' " reduce loading time of large files

" File management
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

" General
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'

" Python development
Plugin 'vim-scripts/indentpython.vim'
Plugin 'klen/python-mode'
" Bundle 'Valloric/YouCompleteMe'

" R Development
Plugin 'jalvesaq/R-Vim-runtime'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'vim-pandoc/vim-rmarkdown'

" LaTeX
" Plugin 'LaTeX-Suite-aka-Vim-LaTeX'
" Bundle 'git://git.code.sf.net/p/vim-latex/vim-latex'
Plugin 'latex-box-team/latex-box'
" Plugin 'lervag/vimtex'

" Colors!
Plugin 'tomasr/molokai'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ================ GENERAL CONFIGURATION =====================

syntax enable
set nocompatible  " Use Vim settings, rather then Vi settings (much better!).
set smarttab      " Make backspace back up a tabstop. Especially handy for editing Python
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set shortmess+=A  " don't show warning messages if a .swp file already exists
set history=50		" keep 50 lines of command line history
set incsearch		" do incremental searching
set ignorecase    " case insensitive searching
set hidden		   " allow hidden buffers in normal mode wrap lines and break at work boundries
set wrap
set linebreak
set nu            " show line number
set ts=2 sw=2 et  " tab stops and shift width == 3 and expand tabs to spaces
set showmatch     " show matching brackets
set cindent
set cino=g1h1
set breakindent
set clipboard=unnamed " allows for copying to system clipboard
set encoding=utf-8
" syntax sync minlines=200 " correct syntax highlighting
set listchars=tab:\|\ 
set list

" Enable folding with the spacebar
nnoremap <space> za

" Enable spell checking
set spell spelllang=en_us

" NERDTree shortcut
:command! NE NERDTree
:command! NEM NERDTreeMirror

" Turn on a fancy status line
set statusline=%m\ [File:\ %f]\ [Type:\ %Y]\ [ASCII:\ %03.3b]\ [Col:\ %03v]\ [Line:\ %04l\ of\ %L]
set laststatus=2  " always show the status line

" Turn off swap files. Gets rid of annoying warnings that the file is open in
" two windows and keeps dirs from getting cluttered with .swp files but at the
" cost of greater risk of losing work.
set updatecount=0

" this combination of options causes a backup file to be written before a write
" begins but that file is deleted as soon as the write succeeds so we don't get
" a bunch of files ending with "~" cluttering things up.
set writebackup
set nobackup

" Enable file type detection.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin on
" set omnifunc=syntaxcomplete#Complete
set t_Co=256
colorscheme solarized

if ! has("gui_running")

  " Make vimdiff colors not suck
  highlight DiffAdd cterm=none ctermfg=Black ctermbg=Green
  highlight DiffDelete cterm=none ctermfg=Black ctermbg=Red
  highlight DiffChange cterm=none ctermfg=Black ctermbg=Yellow
  highlight DiffText cterm=none ctermfg=Black ctermbg=Magenta
endif

" =============== BUILD COMMANDS ===========================

" <F4> goes to the next error when compiling
" Also map C-n and C-p in regular. These are particularly handy in screen
" sessions 'cause screen seems to grab F4
map <F4> :cn<CR>
nmap <C-n> :cn<CR>
nmap <C-p> :cp<CR>

" Set up a :Scons command to build via scons. Arguments are just passed
" through to scons.
function! BuildWithScons(...)
 " a:0 == # of args to the command
 if a:0 == 0
    let &makeprg="scons -u"
 else
    let &makeprg = "scons -u " . join(a:000)
 endif
 :make!
endfunction

command! -narg=* -complete=file S :call BuildWithScons(<f-args>)|:copen|:winc J
" Run checkstyle, cleanup the error format, set the error format, etc.
function! RunSconsCheckstyle()
   let &l:efm = '%f %l %c %m'
   let &makeprg = 'scons -u checkstyle \|& python ~/.vim/util_scripts/cleanup_checkstyle_quickfix.py'
   :make!
   :copen
   :winc J
endfunction
command! Sc :call RunSconsCheckstyle()

" Scons config files (SConstruct and SConscript) are really python files.
au BufNewFile,BufRead SConstruct setlocal filetype=python
au BufNewFile,BufRead SConscript setlocal filetype=python

" ================== LANGUAGE SPECIFIC =================================
" Note some of this is also done via ~/.vim/indent, ~/.vim/ftplugin, etc.
" =======================================================================

" If editing a commmit file, automatically go to the top of the file and enter insert mode
au BufNewFile,BufRead *svn-commit*tmp  :1 | :start!
au BufNewFile,BufRead *.git/COMMIT_EDITMSG :1 | :start!

" YCM options
let g:ycm_filetype_blacklist = { 'LaTeX': 1 }

" Set filetype of .tex files to tex, not plaintex
let g:tex_flavor = "latex"
