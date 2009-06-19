set omnifunc=pythoncomplete#Complete

set path+=/usr/lib/python2.6/,/usr/lib/python2.6/site-packages
set tags+=~/.vim/tags/python/tags


abbreviate <buffer> sefl self
abbreviate <buffer> slef self

" To use quickfix with python programs:
setlocal makeprg=python\ %


" This is quite good for python scripts
setlocal expandtab
setlocal smarttab
setlocal shiftwidth=4

" Remove trailing whitespaces when saving:
autocmd bufwritepre * :%s/\s\+$//e
