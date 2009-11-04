let g:author="TANGUY Arnaud"
let g:email="arn.tanguy@gmail.com"
let g:licence="GNU GPL v2 or later (at your option)"


let g:vjde_window_svr_cmd=0
" ====== Mappings ===== "
" 'cd' towards the dir in which is the file edited
map ,cd :cd %:p:h<CR>

nnoremap <F4> command! -nargs=0 GHPH call <SID>GrabFromHeaderPasteInSource(0,0,3)

set foldmethod=syntax
set nocompatible
set encoding=utf-8
set showcmd
set showmode
set ruler
syntax on

set autowriteall
autocmd QuickFixCmdPre make w
set wildmenu
set wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz

"set ignorecase
"Case sensitive search only if an upper case character is included in the
"search pattern :)
set smartcase
set hlsearch
set incsearch
filetype plugin on

set history=10000

" Yes, I know, I should completly throw my mouse, but it can still be useful
set mouse=a

" Tabulations
set shiftwidth=4
set tabstop=4
" Spaces instead of tabs
set expandtab
set smartindent

" Colors are more visible on dark background with this option.
set background=dark

" smarter J
set nojoinspaces

" isfname:
set isfname-==

" Status line
set laststatus=2
set statusline=%{VimBuddy()}\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" ===== PLUGINS CONFIG =====

" ** Plugin Project
nmap <F1> :Project<cr>
" Quick help:
" - \c  : create a project
" - <space> : extend the project window, or reduce it
"

set tags+=~/.vim/tags/qt4
set tags+=~/.vim/tags/sfml
set tags+=~/.vim/tags/stl

" build tags of your own project with CTRL+F12
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
noremap <F2> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
inoremap <F2> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview


"TagList
let Tlist_Show_One_File = 1


"LAtex
"
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
