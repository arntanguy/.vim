" ================================================================================
" =============================== Global Config=================================== 
" ================================================================================
set nocompatible              " be iMproved
filetype off                  " required!
"set term=xterm
set shell=/bin/bash

" multicore make
"let &makeprg = 'make -j'.system('grep -c ^processor /proc/cpuinfo') 
let &makeprg = 'make -j4'
let mapleader=","
let maplocalleader=","

" Disable mouse support
"set mouse=
" ================================================================================
" =============================== Vundle  ======================================== 
" ================================================================================
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

Bundle 'Valloric/YouCompleteMe'
"
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

"
" Snippets
Bundle 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Bundle 'geenux/vim-snippets'


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


let g:formatprg_cpp = "/usr/bin/astyle"
let g:formatprg_args_cpp = "--options=/home/arnaud/.vim/astyle_options"
let g:formatprg_ino = "/usr/bin/astyle"
let g:formatprg_args_ino = "--options=/home/arnaud/.vim/astyle_options"
Bundle "Chiel92/vim-autoformat"
noremap <F3> :Autoformat<CR><CR>
" Indent on save hook
"autocmd BufWritePre <buffer> Autoformat

" To run commands in the background
" Run :Make for foregournd build
" Run :Make! for background build
" Use :Copen to open the quickfix window (whether build is still running
" or not
" Use :Start instead of :! to run external commands
Bundle "tpope/vim-dispatch"
noremap <F10> :Make!<CR><CR>
" Toggle quickfix window
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    :Copen
    let g:qfix_win = bufnr("$")
  endif
endfunction
noremap <F11> :Copen<CR>
noremap <F12> :cclose<CR>

" Plugin to help manage the pandoc blog
Bundle 'vim-pandoc'
" Bundle 'petRUShka/vim-opencl'

Bundle 'a.vim'
Bundle 'surround.vim'
Bundle 'DoxygenToolkit.vim'
Bundle 'tmhedberg/matchit'

" For google prototxt
Bundle 'protodef'

"Useful status bar
Bundle 'Lokaltog/powerline'
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
"set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
let g:Powerline_symbols = 'fancy'

" Molokai theme
" Bundle 'molokai'
Bundle 'nielsmadan/harlequin'



" Structure of file, jump to function...
" Open with :TlistOpen
Bundle 'taglist.vim'


" CtrlP: easy opening of files
Bundle 'kien/ctrlp.vim'
" Better matcher for ctrlp
Bundle 'burke/matcher'
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


"" ROS
Bundle 'taketwo/vim-ros'



"" ARDUINO
" <leader>ac  - compile
" <leader>ad  - deploy
" <leader>as  - deplay and show serial debug (ino serial)
Bundle 'jplaut/vim-arduino-ino'
Bundle 'sudar/vim-arduino-syntax'


" Reference completion using ycm
" Only considers bib files in the same directory
"Bundle 'bjoernd/vim-ycm-tex'
"let g:ycm_semantic_triggers = {
"\  'tex'  : ['\ref{','\cite{'],
"\ }

syntax on
" Clear syntax highlighting on Esc
nnoremap <silent> <esc> :noh<cr><esc>


if has('gui_running')
  set guifont=Inconsolata\ Medium\ 12
endif


" 'cd' towards the dir in which is the file edited
map <leader>cd :cd %:p:h<CR>

" write file automatically (for :make, :next, Ctrl-]....)
set autowriteall
set history=10000

" smarter J (mege line)
set nojoinspaces

"Show the cursor line in an another color
set number
"hi CursorLine guibg=#e7ebff

set enc=utf-8
set fileencoding=utf-8 

" ================================================================================
" ================================== Code ========================================
" ================================================================================
filetype plugin indent on     " required!

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

"Case sensitive search only if an upper case character is included in the
"search pattern :)
set smartcase
set hlsearch
set incsearch

" Completion in command line
set wildmenu
set wildignore =*.o,*.r,*.so,*.sl,*.tar,*.tgz

" build tags of your own project with F2 in insert and normal mode
noremap <F2> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
inoremap <F2> <Esc>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
noremap <F9> :make! -j8<cr>
inoremap <F9> :make! -j8<cr>


" ================================================================================ 
" MATLAB
" ================================================================================  
Bundle "geenux/matlab_vim"
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
" ==============================================================================
" LaTex
" ==============================================================================
Bundle 'LaTeX-Box-Team/LaTeX-Box'
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
" ================================================================================
" ======================== FILE TYPE SPECIFIC " ==================================
" ================================================================================

" GLSL
"autocmd BufNewFile,BufRead *.frag,*.vert,*.geom,*gp,*.fp,*.vp,*.glsl setf glsl

" Opencl
autocmd BufNewFile,BufRead *.cl set filetype=opencl


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
" Close preview window when selection has been made
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

""use omnicomplete whenever there's no completion engine in youcompleteme (for
""example, in the case of PHP)
"set omnifunc=syntaxcomplete#Complete
"
"" Add triggers to ycm for LaTeX-Box autocompletion
"let g:ycm_semantic_triggers = {
"\  'tex'  : ['{'],
"\ }

" ================================================================================
" ============================== VIM MARKDOWN ====================================
" ================================================================================
" Disable folding
let g:vim_markdown_folding_disabled=1
" Set initial foldlevel. (default is 0: all closed)
let g:vim_markdown_initial_foldlevel=1






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





