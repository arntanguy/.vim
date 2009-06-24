" File found on http://www.metal3d.org/index.php/blog/ticket/2008/12/08/vim-est-un-IDE-PHP, slightly modified by TANGUY Arnaud
" Let unix format, utf8, see line number... etc...
set fileformat=unix
set encoding=utf-8
set number

"My prefered values :)
set shiftwidth=4
set tabstop=4
set nowrapscan
set ignorecase
set expandtab
set showtabline=2
set foldmethod=marker
set hlsearch

" autocommads on php files
set complete=.,w,b,u,t,i,k~/.vim/syntax/php.api
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" <Leader> is "\"... but on azerty keyboard it better to use "," wich is more accessible
:let mapleader = ","

"Use Project"
runtime! ~/.vim/plugin/Project.vim


" Create tags with '\1' command
function! Phptags()   
    "change exclude for your project, here it's a good exclude for Copix temp and var files"
    let cmd = '!ctags -f .tags -h ".php" -R --exclude="\.svn" --exclude="\.git" --exclude="./var" --exclude="./temp" --totals=yes --tag-relative=yes'
    exec cmd
    set tags=.tags
endfunction
:let g:proj_run1='call Phptags()'

"to remap \1 on ,1
nmap ,1 \1

function! PHPCheckSyntax()
  let winnum =winnr() " get current window number
  silent make -l %
  cw " open the error window if it contains error
  " return to the window with cursor set on the line of the first error (if any)
  execute winnum . "wincmd w"
endfunction

:setl makeprg=php
:set errorformat=%m\ in\ %f\ on\ line\ %l

" Map F9 to check the file for syntax
noremap <F9> :call PHPCheckSyntax()<CR><c-l>

let php_sql_query = 1 "Coloration des requetes SQL
let php_htmlInStrings = 1 "Coloration des balises html


" ==== PHP plugin ==== "
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR> 
