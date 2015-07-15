" ================================================================================
" =============================== Global Config===================================
" ================================================================================
set nocompatible              " be iMproved
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
"let &makeprg = 'make -j'.system('grep -c ^processor /proc/cpuinfo') let &makeprg = 'make -j4'

let mapleader = ","

if has("nvim")
    tnoremap <Esc> <C-\><C-n>
endif
" remaps annoying ex mode to repeat macro
nnoremap Q @@

" Disable mouse support
"set mouse=

" Plug {{{
" ================================================================================
" =============================== Vim-plug======================================== 
" ================================================================================
set rtp+=~/.vim/plugged
call plug#begin('~/.vim/plugged')


Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch':  'stable' }
" Snippets
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'Chiel92/vim-autoformat'
Plug 'benekastah/neomake'
" Plugin to help manage the pandoc blog
Plug 'vim-pandoc'
" Plug 'petRUShka/vim-opencl'
Plug 'surround.vim'
Plug 'DoxygenToolkit.vim'

" For google prototxt
Plug 'protodef'
" Molokai theme
" Plug 'molokai'
Plug 'nielsmadan/harlequin'
" CtrlP: easy opening of files
Plug 'kien/ctrlp.vim'
Plug 'burke/matcher'
"" ROS
Plug 'taketwo/vim-ros'
Plug 'jplaut/vim-arduino-ino'
Plug 'sudar/vim-arduino-syntax'
Plug 'geenux/matlab_vim'
Plug 'LaTeX-Box-Team/LaTeX-Box'
" Seamless navigation between tmux
" and vim with C-[h|j|k|l]
Plug 'christoomey/vim-tmux-navigator'

Plug 'bling/vim-airline'
Plug 'spiiph/vim-space'
" comment using gc<command> or gcc (one line or selection)
Plug 'tpope/vim-commentary'
call plug#end()
" }}}

" Appearance {{{
if has('gui_running')
  set guifont=Inconsolata\ Medium\ 12
endif
colorscheme harlequin
" }}}

" vim-commentary {{{
autocmd FileType c,cpp set commentstring=//\ %s
" }}}


" Vim-airline {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
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

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}


" Astyle {{{
" let g:formatprg_cpp = "/usr/bin/astyle"
" let g:formatprg_args_cpp = "--options=/home/arnaud/.vim/astyle_options"
" let g:formatprg_ino = "/usr/bin/astyle"
" let g:formatprg_args_ino = "--options=/home/arnaud/.vim/astyle_options"

let g:formatdef_clang_google_cpp = '"clang-format -style=google"'
let g:formatdef_clang_llvm_cpp = '"clang-format -style=LLVM"'
let g:formatters_cpp = ['clang_google_cpp', 'clang_llvm_cpp']
noremap <F3> :Autoformat<CR><CR>
" }}}


" Neomake {{{
""""""""""""""""""""""""""""""""""""""""""""
" Asynchronous make using neovim features
" (works in vim without asynchronous features)
"""""""""""""""""""""""""""""""""""""""""""
let g:neomake_open_list=1
let g:neomake_list_height=10
noremap <F10> :Neomake! <CR>
noremap <F11> :copen<CR>
noremap <F12> :cclose<CR>
" }}}


" Powerline {{{
""" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
"" Not yet compatible with neovim, disable for now
""" !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

"" "Useful status bar
"" Plug 'Lokaltog/powerline'
"" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
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
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files . -co --exclude-standard']
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
let g:LatexBox_latexmk_async=1
let g:LatexBox_latexmk_options="-pdf"
let g:LatexBox_output_type="pdf"
let g:LatexBox_viewer="evince"

" vim conceal feature for LaTeX
" Activates it
" (0: no conceal, 1: replaced with one char, 2 highlighted with conceal group,
" 3 conceal completely hidden)
set cole=0
hi Conceal guibg=black guifg=white
" Disable superscript concealement
" a = conceal accents/ligatures
" d = conceal delimiters
" g = conceal Greek
" m = conceal math symbols
" s = conceal superscripts/subscripts
let g:tex_conceal="adgm"
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
" disable ycm
nnoremap <leader>yd :let g:ycm_min_num_of_chars_for_completion=200000000<CR>
" enable ycm
nnoremap <leader>ya :let g:ycm_min_num_of_chars_for_completion=2<CR>
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

