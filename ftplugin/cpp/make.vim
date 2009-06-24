"    Copyright (C) 2008  TANGUY Arnaud <arn.tanguy@gmail.com>
"                                                                             *
" This program is free software; you can redistribute it and/or modify        *
" it under the terms of the GNU General Public License as published by        *
" the Free Software Foundation; version 3 of the License                      * 
"                                                                             *
" This program is distributed in the hope that it will be useful,             *
" but WITHOUT ANY WARRANTY; without even the implied warranty of              *
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the                *
" GNU General Public License for more details.                                *
"                                                                             *
" You should have received a copy of the GNU General Public License along     *
" with this program; if not, write to the Free Software Foundation, Inc.,     *
" 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.                 *
"******************************************************************************/
"
" This is my first vim plugin, so there might be errors or inaccuracies. If
" you see some mistakes, please let me know.
"   
" *************** DESCRIPTION **********************
" This is a make plugin for cpp files. It makes, and parse the results to add
" usefull informations, such as auto-include headers.
"
" **************** FEATURES ************************
" Features wished but not implemented yet:
" - Auto add includes after compilation
"   Ok when other includes are already presents: add the includes at the
"   position of the first #include match
" - Show the quickfix window
"
" **************  TODO *******************
" - Guess where to add includes, if none are set in the file
" - Auto add pre-declaration (class Type;) in the header, and the include in
"   the .cpp file.  To switch beetween files, use a.vim plugin.
" - Provide some global options to configure everything

" Do not reload if already loaded
if exists('g:loaded_make_plugin')
  \ && !exists('g:force_reload_make_plugin')
   finish
endif
let g:loaded_make_plugin= 1


" Function : SortUnique
" Purpose  :  Works like sort(), optionally taking in a comparator 
"             (just like the original), except that duplicate entries will be removed.
" Args     : A list, and optionally a comparator
" Returns  : The sorted list 
" Author   : Unknown, found on http://vim.wikia.com/wiki/Unique_sorting 
" TODO     : Check if the include is in the path, otherwise, ask the user to
"            know what to do.
function! SortUnique( list, ... )
  let dictionary = {}
  for i in a:list
    execute "let dictionary[ '" . i . "' ] = ''"
  endfor
  let result = []
  if ( exists( 'a:1' ) )
    let result = sort( keys( dictionary ), a:1 )
  else
    let result = sort( keys( dictionary ) )
  endif
  return result
endfunction

" Function : RemoveMatching
" Purpose  : Delete items in a list, when they are matching items in an
"            another list
" Args     : listRef: The list from which you want to remove items 
"            listMatch: The list to compare with
" Returns  : The listRef, without matched items 
" Author   : TANGUY Arnaud <arn.tanguy@gmail.com>
" Note     : This can surely be improved, but I still don't know much viml
function! RemoveMatching(listRef, listMatch)
    let i=0
    let ref_list = copy(a:listRef)
    while i<len(ref_list)
        for j in a:listMatch
            if ref_list[i] == j
                echomsg "Match j : ".ref_list[i]." ".j
                call remove(ref_list, i)
            endif
        endfor
        let i += 1
    endwhile
    return ref_list
endfunction

" Function : GetMissingIncludes (PRIVATE)
" Purpose  : Find the missing includes in the compilation error list
" Args     : None
" Returns  : Nothing
" Author   : TANGUY Arnaud <arn.tanguy@gmail.com>
" TODO     : Check if the include is in the path, otherwise, ask the user to
"            know what to do.
"            Is there all possible related errors messages here ? Let me know
"            if it is not the case
function! s:GetMissingIncludes()
    " Get the quickfix errors
    let errors = getqflist()
    let includes = []
    " To avoid some errors with variables names
    let not_includes = []
    let l:count=0
    for i in errors
        if(i["text"] =~ ".* was not declared in this scope")
            " Find the possible name in the error
            let include = substitute(i["text"], '.*erreur:..\(.*\)..was not declared in this scope', '\1', 'g')
            " Check if it is really a type, and not a variable name
            let nextError = errors[l:count + 1]["text"]
            if(nextError =~ ".* expected .;. before .*")
                let not_includes += [substitute(nextError, '.* expected .;. before .\(.*\).', '\1', 'g')]
                let includes += [include]
            endif
        elseif(i["text"] =~ ".*variable .* has initializer but incomplete type")
            let includes += [substitute(i["text"], '.*variable .\(.*\) .* has initializer but incomplete type', '\1', 'g')]
        elseif(i["text"] =~ ".* aggregate .* has incomplete type and cannot be defined")
            let includes += [substitute(i["text"], '.* aggregate .\(.*\) .* has incomplete type and cannot be defined', '\1', 'g')] 
        elseif(i["text"] =~ ".* has not been declared")
            let includes += [substitute(i["text"], '.* .\(.*\). has not been declared', '\1', 'g')]
        elseif(i["text"] =~ ".* incomplete type .* used in nested name specifier") 
            let includes += [substitute(i["text"], '.* incomplete type .\(.*\). used in nested name specifier', '\1', 'g')]
        endif
        let l:count += 1
    endfor
     for ttt in not_includes
         echomsg "Not: ".ttt
     endfor
    " Return the found includes name, and sort them, remove doubles
    "return SortUnique(includes)
    let tmpReturn = RemoveMatching(includes, not_includes) 
    return SortUnique(tmpReturn)
endfunction

" Function : AddIncludes (PRIVATE)
" Purpose  : Add the includes given in args in the file
" Args     : includesList: A list containing the includes name
" Returns  : Nothing
" Author   : TANGUY Arnaud <arn.tanguy@gmail.com>
function s:AddIncludes(includesList)
    if(len(a:includesList) > 0 )
        let l=line(".")
        echomsg l
        exe "normal gg"
        let li = search("#include")
        if (li != 0)  " if found already set includes, set it here
            let l = li
        endif
        for include in a:includesList
            exe "normal ".l."Go#include <".include.">"
        endfor
        " Once the includes are added, rebuild
        silent! execute &makeprg
    endif
endfunction

" Function : MyMake
" Purpose  : Build a cpp project, using make, and doing some more cool stuff.
"            This function call everything needed for this plugin : autoadd includes...
" Args     : None
" Returns  : 1 if path1 is equal to path2, 0 otherwise.
" Author   : TANGUY Arnaud <arn.tanguy@gmail.com>
function! s:MyMake()
    "silent! exe &makeprg
    exe &makeprg
    exe "normal <c-r>"
    let includes = s:GetMissingIncludes()
    call s:AddIncludes(includes)
    let winnum =winnr() " get current window number
    " 6 lines big for the openwindow FIXME : need global config
    cope 6
    " Open the quickfix window
    cw
    " Go to the first error
    execute winnum . "wincmd w"
endf

com! -nargs=0 MyMake		call s:MyMake()
