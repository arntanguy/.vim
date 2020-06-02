

" LaTeX: vimtex {{{
autocmd BufNewFile,BufRead *.tex set ft=tex
let g:tex_flavor = 'latex'
" Quickfix window is opened automatically when there are errors (2), but not
" focused (1)
let g:vimtex_quickfix_mode=2
let g:vimtex_fold_enabled=0
let g:vimtex_latexmk_build_dir = './build'
let g:vimtex_view_general_viewer = 'qpdfview'
let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'
let g:vimtex_view_general_options_latexmk = '--unique'

" Remap double click for latex
autocmd FileType tex nnoremap <silent> <2-LeftMouse> :VimtexView<CR>

" Prevents vim from concealing LaTeX code
let conceallevel=0
set concealcursor=vin

" enable YCM for latex
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
      \ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'
      \ ]
" }}}
