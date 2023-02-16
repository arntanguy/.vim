" Neomake {{{
""""""""""""""""""""""""""""""""""""""""""""
" Asynchronous make using neovim features
" (works in vim without asynchronous features)
"""""""""""""""""""""""""""""""""""""""""""
let g:neomake_open_list=1
let g:neomake_list_height=10
let g:airline#extensions#neomake#enabled=1
" always open quickfix taking the whole horizontal space available
au FileType qf wincmd J
noremap <F10> :cclose<CR>:Neomake! make <CR>
noremap <F11> :copen<CR>
noremap <F12> :cclose<CR>

let g:neomake_verbose = 1
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
"let g:neomake_make_maker = {
"       \ 'exe': 'make',
"       \ 'args': ['VERBOSE=1'],
"       \ 'errorformat': '%f:%l:%c: %t%.%#: %m,'
"       \               .'%-Gninja%.%#,'
"       \               .'%-Gmake:%.%#,'
"       \               .'%-G[%.%#,'
"       \               .'%-G%.%#recipe for target%.%#',
"       \ 'remove_invalid_entries': get(g:, 'neomake_remove_invalid_entries', 0),
"       \ }
"

let g:neomake_enabled_makers = ['install', 'ninja', 'clean']
let g:neomake_ninja_maker = {
         \ 'exe' : 'ninja',
         \ 'cwd' : getcwd().'/build',
         \ 'errorformat' : '%-G%f:%s:,%-G%f:%l: %#error: %#(Each undeclared identifier is reported only%.%#,%-G%f:%l: %#error: %#for each function it appears%.%#,%-GIn file included%.%#,%-G %#from %f:%l\,,%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m,%I%f:%l:%c: note: %m,%f:%l:%c: %m,%f:%l: %trror: %m,%f:%l: %tarning: %m,%I%f:%l: note: %m,%f:%l: %m'
         \ }
let g:neomake_install_maker = {
         \ 'exe' : 'ninja',
         \ 'cwd' : getcwd().'/build',
         \ 'args' : 'install',
         \ 'errorformat' : '%-G%f:%s:,%-G%f:%l: %#error: %#(Each undeclared identifier is reported only%.%#,%-G%f:%l: %#error: %#for each function it appears%.%#,%-GIn file included%.%#,%-G %#from %f:%l\,,%f:%l:%c: %trror: %m,%f:%l:%c: %tarning: %m,%I%f:%l:%c: note: %m,%f:%l:%c: %m,%f:%l: %trror: %m,%f:%l: %tarning: %m,%I%f:%l: note: %m,%f:%l: %m'
         \ }

let g:neomake_clean_maker = {
         \ 'exe' : 'ninja',
         \ 'cwd' : getcwd().'/build',
         \ 'args' : 'clean',
         \ }
" }}}
