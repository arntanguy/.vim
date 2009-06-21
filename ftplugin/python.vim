set omnifunc=pythoncomplete#Complete

set path+=/usr/lib/python2.6/,/usr/lib/python2.6/site-packages
set tags+=~/.vim/tags/python/tags

" To use quickfix with python programs:
setlocal makeprg=python\ %


" This is quite good for python scripts
setlocal expandtab
setlocal smarttab
setlocal shiftwidth=4


" This helps visualising identation blocs
if (has("gui"))
    set cursorline
endif
set cursorcolumn

" Remove trailing whitespaces when saving:
autocmd bufwritepre * :%s/\s\+$//e
