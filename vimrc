" ====== Mappings ===== "
" 'cd' towards the dir in which is the file edited
map ,cd :cd %:p:h<CR>
" Surround selection with caracters
vmap s{ mlo<esc>i{<esc>`lla}
vmap s( mlo<esc>i(<esc>`lla)
vmap s[ mlo<esc>i[<esc>`lla]


set foldmethod=syntax
set nocompatible
set encoding=utf-8
set showcmd
set showmode
set ruler
syntax on

set autowriteall
set wildmenu
set wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz

"set ignorecase
"set smartcase
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
nmap <F1> :Project
" Quick help:
" - \c  : create a project
" - <space> : extend the project window, or reduce it
