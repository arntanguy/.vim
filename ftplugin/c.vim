"Special configuration for C/C++ files

" /!\ this is *not* the default for many projects
setlocal expandtab
setlocal smarttab
setlocal shiftwidth=4


setlocal cindent

" Show trailing whitespaces, and tabs with hideous ^I
"setlocal list listchars=trail:·

" Remove trailing whitespaces when saving:
autocmd bufwritepre * :%s/\s\+$//e

