" ================================================================================
" =============================== Global Config=================================== 
" ================================================================================
set nocompatible              " be iMproved
filetype off                  " required!

syntax on
let mapleader=","

if has('gui_running')
    set guifont=Inconsolata\ Medium\ 11
    " Yes, I know, I should completly throw my mouse, but it can still be useful
endif

" Disable mouse support
set mouse=

" 'cd' towards the dir in which is the file edited
map <leader>cd :cd %:p:h<CR>

" write file automatically (for :make, :next, Ctrl-]....)
set autowriteall
set history=10000

" smarter J (mege line)
set nojoinspaces

"Show the cursor line in an another color
set cursorline
"hi CursorLine guibg=#e7ebff


" ================================================================================
" =============================== Vundle  ======================================== 
" ================================================================================
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" original repos on GitHub
Bundle 'Valloric/YouCompleteMe'
Bundle 'plasticboy/vim-markdown'

Bundle 'a.vim'
" Utility library for vimscripts
Bundle 'L9'
Bundle 'FuzzyFinder'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.




" ================================================================================
" ================================== Code ========================================
" ================================================================================
filetype plugin on
filetype indent on

" Folding
syntax on
set foldmethod=syntax

" Tabulations
set shiftwidth=4
set tabstop=4
" Spaces instead of tabs
set expandtab
set smartindent

"Case sensitive search only if an upper case character is included in the
"search pattern :)
set smartcase
set hlsearch
set incsearch

" Completion in command line
set wildmenu
set wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz

noremap <F9> :make! -j8<cr>
inoremap <F9> :make! -j8<cr>

" ================================================================================
" ======================== FILE TYPE SPECIFIC " ==================================
" ================================================================================

" GLSL
au BufNewFile,BufRead *.frag,*.vert,*.geom,*gp,*.fp,*.vp,*.glsl setf glsl

" OpenCL
au BufNewFile,BufRead *.cl setf opencl

" C++
" Syntax and indentation
"au BufNewFile,BufRead *.cpp set syntax=cpp11




" ==============================================================================
" ============================= YouCompleteMe (YCM) ============================
" ==============================================================================
" Read doc for installation and configuration. 
" Short version:
" - Build with cmake -D CMAKE_EXPORT_COMPILE_COMMANDS="YES"
" - Create a .ycm_extra_conf.py configuration file at the root of your
"   develeppement folder
" - You can use :YcmDiags to see if there were building errors

" Do not ask for confimation before loading YCM build file
let g:ycm_confirm_extra_conf = 0

" ==============================================================================
" ================================= FuzzyFinder ================================
" ==============================================================================
noremap <leader>o :FufFile<cr>
noremap <leader>b :FufBuffer<cr>

" ================================================================================
" ============================== VIM MARKDOWN ====================================
" ================================================================================
" Disable folding
let g:vim_markdown_folding_disabled=1
" Set initial foldlevel. (default is 0: all closed)
let g:vim_markdown_initial_foldlevel=1
