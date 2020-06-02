" ================================================================================
" =============================== Global Config===================================
" ================================================================================
"

let g:mapleader = "\<Space>"
let g:maplocalleader = ','
" By default timeoutlen is 1000 ms
set timeoutlen=500

if has('persistent_undo')
    set undolevels=5000
    set undodir=$HOME/.VIM_UNDO_FILES
    set undofile
endif

" {{{ Make vimrc edition faster:
" Mapping to open vimrc file
" Autosource vimrc on save
nmap <silent>  ;v  :next $MYVIMRC<CR>
augroup VimReload
    autocmd!
    autocmd BufWritePost  $MYVIMRC  source $MYVIMRC
augroup END
" }}}

" Use plugins config {{{
if filereadable(expand("~/.config/nvim/vimrc.plugins"))
  source ~/.config/nvim/vimrc.plugins
endif
" }}}

" Extra configuration for some plugins
source ~/.config/nvim/modules/coc.vim
source ~/.config/nvim/modules/latex.vim
source ~/.config/nvim/modules/vim-whichkey.vim

set hidden
filetype plugin indent on     " required!
filetype off                  " required!
syntax on
" Always display status bar
set laststatus=2
set fileencoding=utf-8
" Open new split panes to right and bottom, which feels more natural than Vim’s default:
set splitbelow
set splitright
"set term=xterm
" set shell=/bin/zsh

" multicore make
let &makeprg = 'make -j'.system('grep -c ^processor /proc/cpuinfo')
" let &makeprg = 'make -j4'

if has("nvim")
    tnoremap <Esc> <C-\><C-n>
endif
" remaps annoying ex mode to repeat macro
nnoremap Q @@

" Enable mouse support
set mouse=a


" Appearance {{{
if has('gui_running')
  set guifont=Inconsolata\ Medium\ 12
endif
set background=dark
colorscheme harlequin
"colorscheme base16-default
"colorscheme mustang
"colorscheme solarized
"colorscheme molokai
set cursorline " Highlight current line
hi CursorLine term=bold cterm=bold guibg=Grey40
"hi YcmErrorLine guibg=#ffffff
"hi YcmErrorLine guibg=#af875f
" }}}

" {{{ CamelCase
" Use default mappings ,w ...
call camelcasemotion#CreateMotionMappings('<leader>')
" }}}

" yankstack {{{
" Make yankstack play nice with surround by forcing yankstack
" to define its key-bindings before surround is loaded.
" See https://github.com/maxbrunsfeld/vim-yankstack/issues/9 for discussion
call yankstack#setup()
" }}}

" vim-commentary {{{
autocmd FileType c,cpp set commentstring=//\ %s
autocmd FileType cmake set commentstring=#\ %s
autocmd FileType matlab setlocal commentstring=%\ %s
" }}}

" Vim-airline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
" }}}

" UtilsSnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
"

" Clang-format {{{
" Fallback: llvm, google, chromium, mozilla
" let g:clang_format#code_style='google'
let g:clang_format#detect_style_file=1

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
"noremap <F3> :ClangFormat<CR>
" }}}


" Neomake {{{
""""""""""""""""""""""""""""""""""""""""""""
" Asynchronous make using neovim features
" (works in vim without asynchronous features)
"""""""""""""""""""""""""""""""""""""""""""
let g:neomake_open_list=1
let g:neomake_list_height=10
" always open quickfix taking the whole horizontal space available
au FileType qf wincmd J
noremap <F10> :cclose<CR>:Neomake! make <CR>
noremap <F11> :copen<CR>
noremap <F12> :cclose<CR>

let g:neomake_verbose = 1
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_make_maker = {
       \ 'exe': 'make',
       \ 'args': ['VERBOSE=1'],
       \ 'errorformat': '%f:%l:%c: %t%.%#: %m,'
       \               .'%-Gninja%.%#,'
       \               .'%-Gmake:%.%#,'
       \               .'%-G[%.%#,'
       \               .'%-G%.%#recipe for target%.%#',
       \ 'remove_invalid_entries': get(g:, 'neomake_remove_invalid_entries', 0),
       \ }
" }}}

" LLDB {{{
nmap <C-b> <Plug>LLBreakSwitch
vmap <F2> <Plug>LLStdInSelected
nnoremap <F4> :LLstdin<CR>
nnoremap <F5> :LLmode debug<CR>
nnoremap <S-F5> :LLmode code<CR>
nnoremap <F8> :LL continue<CR>
nnoremap <S-F8> :LL process interrupt<CR>
nnoremap <F9> :LL print <C-R>=expand('<cword>')<CR>
vnoremap <F9> :<C-U>LL print <C-R>=lldb#util#get_selection()<CR><CR>
" }}}

" vim-ros {{{
let g:ros_make = 'current'
let g:ros_catkin_make_options = '-j4'
" Somehow doesn't work with python3 in neovim
let g:ros_use_python_version = 2
" }}}

" Ctrl-P {{{
" let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
" let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_match_func = { 'match': 'cpsm#CtrlPMatch' }
let g:ctrlp_max_files=0

" Custom Mappings {{{
" 'cd' towards the dir in which is the file edited
map <leader>cd :cd %:p:h<CR>
" }}}

" write file automatically (for :make, :next, Ctrl-]....)
set autowriteall
set history=10000

" smarter J (mege line)
set nojoinspaces

set number
set relativenumber 

" Code {{{
" Folding
set foldmethod=syntax
" All folds open by default
set foldlevel=100

" Tabulations
set shiftwidth=2
set tabstop=2
" Spaces instead of tabs
set expandtab
set smartindent
" }}}

" Completion in command line
set wildmenu
set wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz

" File type specific {{{
" GLSL
"autocmd BufNewFile,BufRead *.frag,*.vert,*.geom,*gp,*.fp,*.vp,*.glsl setf glsl

" Opencl
autocmd BufNewFile,BufRead *.cl set filetype=opencl

" Json
autocmd BufNewFile,BufRead *.conf set filetype=json
autocmd BufNewFile,BufRead *.conf.cmake set filetype=json
" }}}


" Matlab {{{
let g:matlab_auto_mappings = 1 "automatic mappings enabled
let g:matlab_server_launcher = 'vim'  "launch the server in a Neovim terminal buffer
" let g:matlab_server_launcher = 'tmux' "launch the server in a tmux split
let g:matlab_server_split = 'vertical' "launch the server in a vertical split
" }}}

" Markdown {{{
" Disable folding
let g:vim_markdown_folding_disabled=1
" Set initial foldlevel. (default is 0: all closed)
let g:vim_markdown_initial_foldlevel=1
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
" }}}



" Search {{{
"Case sensitive search only if an upper case character is included in the
"search pattern :)
set smartcase
set hlsearch
set incsearch
nmap <silent> <BS>  :nohlsearch<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy/<C-R><C-R>=substitute(
      \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy?<C-R><C-R>=substitute(
      \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gV:call setreg('"', old_reg, old_regtype)<CR>
" }}}

function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function! StripTrailingWhitespace()
    if !&binary && &filetype != 'diff'
      normal mz
      normal Hmy
      %s/\s\+$//e
      normal 'yz<CR>
      normal `z
    endif
endfunction
autocmd FileType c,cpp autocmd BufWritePre <buffer> :%s/\s\+$//e
