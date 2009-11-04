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
" - Auto add includes after compilation (works fine, at least for Qt).
"   But : File names must be named like the class. I.e if you have a class
"   named TestClass, then the file name must be TestClass.h TestClass.hpp or
"   TestClass
"   When other includes are already presents: add the includes with them
"   Otherwise, guess where to add includes : after the header, or at a default
"   position.
" - Show the quickfix window
"
" *************** CONFIGURATION *****************
" g:default_includes_line    the number of the default include line. It is
"                            used when not better place is found
" g:quickfix_size            The number of lines of the quickfix window
"
" **************  TODO *******************
" - Auto (or ask?) add pre-declaration (class Type;) in the header, and the include in
"   the .cpp file.  To switch beetween files, use a.vim plugin.
" - Seek for innacuracies, and fix them. Optimize too...

let s:cpo_save=&cpo
set cpo&vim

" Do not reload if already loaded
if exists('g:loaded_make_plugin')
  \ && !exists('g:force_reload_make_plugin')
   finish
endif
let g:loaded_make_plugin= 1

" Global variables initialisation (if not already set)
if !exists('g:quickfix_size')
    let g:quickfix_size=6
endif


" Function : SortUnique
" Purpose  :  Works like sort(), optionally taking in a comparator
"             (just like the original), except that duplicate entries will be removed.
" Args     : A list, and optionally a comparator
" Returns  : The sorted list
" Author   : Unknown, found on http://vim.wikia.com/wiki/Unique_sorting
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
            "let include = substitute(i["text"], '.*error:..\(.*\)..was not declared in this scope', '\1', 'g')
            let includes += [substitute(i["text"], '.*error:..\(.*\)..was not declared in this scope', '\1', 'g')]
            " Check if it is really a type, and not a variable name
            "let nextError = errors[l:count + 1]["text"]
            "if(nextError =~ ".* expected .;. before .*")
                "let not_includes += [substitute(nextError, '.* expected .;. before .\(.*\).', '\1', 'g')]
                "let includes += [include]
            "endif
        elseif(i["text"] =~ ".*variable .* has initializer but incomplete type")
            let includes += [substitute(i["text"], '.*variable .\(.*\) .* has initializer but incomplete type', '\1', 'g')]
        elseif(i["text"] =~ ".* aggregate .* has incomplete type and cannot be defined")
            let includes += [substitute(i["text"], '.* aggregate .\(.*\) .* has incomplete type and cannot be defined', '\1', 'g')]
        elseif(i["text"] =~ ".* has not been declared")
            let includes += [substitute(i["text"], '.* .\(.*\). has not been declared', '\1', 'g')]
        elseif(i["text"] =~ ".* incomplete type .* used in nested name specifier")
            let includes += [substitute(i["text"], '.* incomplete type .\(.*\). used in nested name specifier', '\1', 'g')]
        elseif(i["text"] =~ ".* invalid use of incomplete type .*")
            let includes += [substitute(i["text"], '.* invalid use of incomplete type .struct \(.*\).', '\1', 'g')]
        endif
        let l:count += 1
    endfor
    " Return the found includes name, and sort them, remove doubles
    let tmpReturn = RemoveMatching(includes, not_includes)
    let tmpReturn = SortUnique(tmpReturn)
    return s:CheckInPath(tmpReturn)
endfunction

" Function : CheckInPath
" Purpose  : Check if an include exists in path
" Args     : The includes names list
" Returns  : A dictionnary of the found entry :
"               "global" => List   : The global entry (those included with
"               #include <...>)
"               "local" => List    : The local entry (those included with
"               #include "..."
"               "unmatched" => List : The includes not found
" Author   : TANGUY Arnaud  <arn.tanguy@gmail.com>
function! s:CheckInPath(includesList)
    let includes = copy(a:includesList)
    let results = { "global" : [],
                    \"local" : [],
                    \"unmatched": [] }
    for inc  in includes
      let mpath="**,/usr/include/**"
      let found = findfile(inc, mpath)
      if found != ""
          let results["global"] += [inc]
      else
          " XXX : strange, why regex don't works with findfile ?
          let found = findfile(inc.".h", mpath)
          if(found != "")
              let results["local"] += [found]
          else
              let found = findfile(inc.".hpp", mpath)
              if found != ""
                  let results["local"] += [found]
              else
                  let results["unmatched"] += [inc]
              endif
          endif
      endif
    endfor
    for i in results["global"]
        echomsg "global : ".i
    endfor
    for j in results["local"]
        echomsg "local : ".j
    endfor
    for h in results["unmatched"]
        echomsg "unmatched : ".h
    endfor
    return results
endfunction

" Function : SeekPosition
" Purpose  : Find the best position where the includes will be placed
" Args     : None
" Returns  : The found line
" Author   : TANGUY Arnaud
function! s:SeekPosition()
    exe "normal gg"
    " Seek the existing includes, to add it here if they exists
    let line = search("^#include")
    if line > 0
       return line
    endif

    " Otherwise, find a default location. Usually, C files are written with a
    " header, and space is left between header and code. So, we'll seek the
    " first line without anything but white character on it
    let line = search('^\( ?\)*$')
    if line > 0
        return line
    endif

    " If not found, set a default value
    if exists("g:default_includes_line")
        return g:default_includes_line
    else
        return 1
    endif
endfunction


" Function : AddIncludes (PRIVATE)
" Purpose  : Add the includes given in args in the file
" Args     : includesDict: A list containing the includes name and type
"               "global" => global includes
"               "local" => local includes
"               "unmatched" => not found, so ask
" Returns  : Nothing
" Author   : TANGUY Arnaud <arn.tanguy@gmail.com>
function s:AddIncludes(includesDict)
    if(len(a:includesDict) > 0 )
        let l=s:SeekPosition()
        for include in a:includesDict["local"]
            exe "normal ".l.'GO#include "'.include.'"'
        endfor
        for inc in a:includesDict["global"]
            exe "normal ".l.'GO#include <'.inc.'>'
        endfor
        for i in a:includesDict["unmatched"]
            echomsg "unmatched ".i
        endfor

        " Once the includes are added, rebuild
        silent! execute &makeprg
    endif
endfunction

" Function : MyMake
" Purpose  : Build a cpp project, using make, and doing some more cool stuff.
"            This function call everything needed for this plugin : autoadd
"            includes...
" Args     : None
" Returns  : 1 if path1 is equal to path2, 0 otherwise.
" Author   : TANGUY Arnaud <arn.tanguy@gmail.com>
function! s:MakeIncludes(dir)
    "exe &makeprg
    call s:Make(a:dir)
    let includes = s:GetMissingIncludes()
    call s:AddIncludes(includes)
endf

" Function : s:Make
" Purpose  :
" Args     :
" Returns  :
" Author   : TANGUY Arnaud
function s:Make(dir)
    " Save the old directory, and go to the new one
    let olddir=getcwd()
    if(a:dir  != "")
        execute ":lcd ".a:dir
    endif
    silent! exe &makeprg
    execute ":lcd ".olddir
    let winnum =winnr() " get current window number
    " g:quickfix_size lines big for the quickfix window
    exe "cope ".g:quickfix_size
    " Open the quickfix window
    cw
    " Go to the first error
    execute winnum . "wincmd w"
endfunction


com! -nargs=0 Mi   call s:MakeIncludes(".")
com! -nargs=0 Mid   call s:MakeIncludes(<args>)
com! -nargs=0 Mm  call s:Make(".")
" Make in an other directory
com! -nargs=1 Mmd  call s:Make(<args>)

let &cpo=s:cpo_save
