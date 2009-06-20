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
    let cmd = '!ctags -f .tags -h ".php" -R --exclude="\.svn" --exclude="./var" --exclude="./temp" --totals=yes --tag-relative=yes'
    exec cmd
    set tags=.tags
endfunction
:let g:proj_run1='call Phptags()'

"to remap \1 on ,1
nmap ,1 \1

" F9 will do a PHP lint ! (ie: building test)
set makeprg="php -l %"
nmap <F1> :make<cr>

