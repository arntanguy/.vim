" Configuration file for tex
"

"let g:Imap_FreezeImap=0

function! g:Switch_Imap_FreezeImap() 
   if g:Imap_FreezeImap == 1
     let g:Imap_FreezeImap = 0
   else
     let g:Imap_FreezeImap = 1
   endif 
endfunction
inoremap <c-i> <esc>:call g:Switch_Imap_FreezeImap()<cr>a

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2
set tabstop=2
filetype indent on

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" Activate spell chek:
setlocal spell spelllang=fr

" Set textwidth:
set textwidth=80

" Disable autoindent:
set noautoindent

"  Useful imaps:

imap <buffer> ... \ldots

imap <buffer> « \og
imap <buffer> » \fg

imap <buffer> € \EUR
imap <buffer>~ $\sim\ 

imap <buffer> // \\
imap <buffer> /np \newpage


" Using imaps.vim

call IMAP("/e","é","tex")
call IMAP ("/em" , "\\emph{<++>} <++>" , "tex")


call IMAP ("/s3" , "\\subsubsection{ <++> }\<CR><++>" , "tex")
call IMAP ("/s2" , "\\subsection{ <++> }\<CR><++>" , "tex")
call IMAP ("/s1" , "\\section{ <++> }\<CR><++>" , "tex")

call IMAP ("/p" , "\\paragraph{ <++> }<++>" , "tex")
call IMAP ("/sp" , "\\subparagraph{ <++> } <++>" , "tex")

call IMAP ("/bit", "\\begin{itemize}\<cr>\\item <++>\<cr>\\end{itemize}\<cr><++>", "tex")

call IMAP("/footnote", "\\footnote{ <++> } <++>", "tex")

call IMAP("\item", "\\item <++>", "tex")

call IMAP("/fig", "\\begin{figure}\<cr>\\centering\\includegraphics[<++>]{<++>}\<cr>\\caption{<++>}\<cr>\\label{<++>}\<cr>\\end{figure}", "tex")

" Fix the é bug
imap <buffer> <leader>it <Plug>Tex_InsertItemOnThisLine

