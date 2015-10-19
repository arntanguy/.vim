" ================================================================================
" =============================== Global Config===================================
" ================================================================================
set nocompatible              " be iMproved
set hidden
filetype plugin indent on     " required!
filetype off                  " required!
syntax on
set enc=utf-8
" Always display status bar
set laststatus=2
set fileencoding=utf-8
"set term=xterm
set shell=/bin/bash

" multicore make
let &makeprg = 'make -j'.system('grep -c ^processor /proc/cpuinfo') 
" let &makeprg = 'make -j4'

let mapleader = ","

if has("nvim")
    tnoremap <Esc> <C-\><C-n>
endif
" remaps annoying ex mode to repeat macro
nnoremap Q @@

" Disable mouse support
"set mouse=

" Use plugins config {{{
if filereadable(expand("~/.nvimrc.plugins"))
  source ~/.nvimrc.plugins
endif
" }}}

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
hi YcmErrorLine guibg=#003f00
" }}}

" vim-commentary {{{
autocmd FileType c,cpp set commentstring=//\ %s
autocmd FileType cmake set commentstring=#\ %s
" }}}

" Vim-grepper {{{
"
" <leader>g in normal mode will prompt for a new search term 
" <leader>g in visual mode will adopt the current visual selection.
" <leader>g at the search prompt will switch to the next grep tool.
" gs is an operator and takes any motion, e.g. gsi( or gsap.
" Use <up> and <down> for going through the input history or use <c-f> to open it in the cmdwin.
nmap <leader>g <plug>(Grepper)
xmap <leader>g <plug>(Grepper)
cmap <leader>g <plug>(GrepperNext)
nmap gs        <plug>(GrepperMotion)
xmap gs        <plug>(GrepperMotion)
" }}}

" Vim-airline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
" }}}

" Space.vim {{{
function! SlSpace()
    if exists("*GetSpaceMovement")
        return "[" . GetSpaceMovement() . "]"
    else
        return ""
    endif
endfunc
set statusline+=%{SlSpace()}
" }}}

" YCM {{{
" Jumps to definition. Add entries to vim's jump list, so you can jump back
" with Ctrl-O (Ctrl-I to jump forward)
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>                " turn off YCM
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>                "turn on YCM
set conceallevel=2
set concealcursor=vin
let g:clang_snippets=1
let g:clang_conceal_snippets=1
" The single one that works with clang_complete
let g:clang_snippets_engine='clang_complete'
" Complete options (disable preview scratch window, longest removed to aways
" show menu)
set completeopt=menu,menuone
" Limit popup menu height
set pumheight=20

" Open preview window for completions
let g:ycm_add_preview_to_completeopt=1
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=1

" For ros Files
let g:ycm_semantic_triggers = {
\   'roslaunch' : ['="', '$(', '/'],
\   'rosmsg,rossrv,rosaction' : ['re!^', '/'],
\ }

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
let g:clang_format#code_style='google'
let g:clang_format#detect_style_file=1

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
noremap <F3> :ClangFormat<CR>
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
noremap <F10> :cclose<CR>:Neomake! <CR>
noremap <F11> :copen<CR>
noremap <F12> :cclose<CR>
" }}}

" vim-ros {{{
let g:ros_make = 'current'
let g:ros_catkin_make_options = '-j4'
" }}}

" Powerline {{{
""" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"" Not yet compatible with neovim, disable for now
""" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

"" "Useful status bar
"" Plug 'Lokaltog/powerline'
"" set rtp+=~/.nvim/bundle/powerline/powerline/bindings/vim
"" "set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
"" " Always show statusline
"" set laststatus=2
"" " Use 256 colours (Use this setting only if your terminal supports 256 colours)
"" set t_Co=256
"" let g:Powerline_symbols = 'fancy'
" }}}



" Ctrl-P {{{
" Better matcher for ctrlp
let g:path_to_matcher = "/usr/local/bin/matcher"
"let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_user_command = ['ag -l --nocolor -g ""']
let g:ctrlp_match_func = { 'match': 'GoodMatch' }
function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)
  " Create a cache file if not yet exists
  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
    call writefile(a:items, cachefile)
  endif
  if !filereadable(cachefile)
    return []
  endif
  " a:mmode is currently ignored. In the future, we should probably do
  " something about that. the matcher behaves like "full-line".
  let cmd = g:path_to_matcher.' --limit '.a:limit.' --manifest '.cachefile.' '
  if !( exists('g:ctrlp_dotfiles') && g:ctrlp_dotfiles )
    let cmd = cmd.'--no-dotfiles '
  endif
  let cmd = cmd.a:str
  return split(system(cmd), "\n")
endfunction
" }}}

" Ctrl-Space {{{
" List files (takes into account .gitignore)
set showtabline=0
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
" }}}


"" ARDUINO {{{
" <leader>ac  - compile
" <leader>ad  - deploy
" <leader>as  - deplay and show serial debug (ino serial)
" }}}

" Custom Mappings {{{
" 'cd' towards the dir in which is the file edited
map <leader>cd :cd %:p:h<CR>
" }}}

" write file automatically (for :make, :next, Ctrl-]....)
set autowriteall
set history=10000

" smarter J (mege line)
set nojoinspaces

"Show the cursor line in an another color
set number
"hi CursorLine guibg=#e7ebff


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

" Matlab {{{
source $VIMRUNTIME/macros/matchit.vim

function! MatRunCellAdvanced()
   execute "!echo \"cd(\'".expand("%:p:h")."\')\">/tmp/buff"
   :?%%?;/%%/w>> /tmp/buff
   execute "!echo \"edit ".expand("%:f")."\">>/tmp/buff"
   !cat /tmp/buff|xclip -selection c
   !cat /tmp/buff|xclip
   !quickswitch.py -r MATLAB
   "!wmctrl -a MATLAB
endfunction
map ,n :call MatRunCellAdvanced()  <cr><cr>
" }}}


" Latex {{{
autocmd BufNewFile,BufRead *.tex set ft=tex
" }}}


" File type specific {{{
" GLSL
"autocmd BufNewFile,BufRead *.frag,*.vert,*.geom,*gp,*.fp,*.vp,*.glsl setf glsl

" Opencl
autocmd BufNewFile,BufRead *.cl set filetype=opencl
" }}}


" YouCompleteMe (YCM) {{{
" Read doc for installation and configuration.
" Short version:
" - Build with cmake -D CMAKE_EXPORT_COMPILE_COMMANDS="YES"
" - Create a .ycm_extra_conf.py configuration file at the root of your
"   develeppement folder
" - You can use :YcmDiags to see if there were building errors

" Do not ask for confimation before loading YCM build file
let g:ycm_confirm_extra_conf = 0
" Close preview window when selection has been made
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" The various GoTo* subcommands add entries to Vim's jumplist so you can use CTRL-O to jump back to where you where before invoking the command (and CTRL-I to jump forward; see :h jumplist for details).
nnoremap <leader>jd :YcmCompleter GoTo<CR>
" }}}


" Markdown {{{
" Disable folding
let g:vim_markdown_folding_disabled=1
" Set initial foldlevel. (default is 0: all closed)
let g:vim_markdown_initial_foldlevel=1
" }}}



" Search {{{
"Case sensitive search only if an upper case character is included in the
"search pattern :)
set smartcase
set hlsearch
set incsearch

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

