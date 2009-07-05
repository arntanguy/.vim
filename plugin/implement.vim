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
" This is one of my first vim plugin, so there might be errors or inaccuracies. If
" you see some mistakes, please let me know.
"
" *************** DESCRIPTION **********************
" This plugin autocreate an implement file from a class, writing function
" skeletons in the wanted location.
"
" **************** FEATURES ************************
"
" *************** CONFIGURATION *****************
"
" **************  TODO *******************
" - Parse a class, find functions, and create their skeleton

let s:cpo_save=&cpo
set cpo&vim

" Do not reload if already loaded
if exists('g:loaded_implement_plugin')
  \ && !exists('g:force_reload_implement_plugin')
   finish
endif
let g:loaded_implement_plugin= 1

" Function : s:ParseFunction
" Purpose  :
" Args     :
" Returns  :
" Author   : TANGUY Arnaud
function s:ParseFunction(prototype)
    let proto = substitute(a:prototype, '^ *\(.*\) *$', '\1', '')
    let func = substitute(proto, '; *$', '\r{\r\r}', '')
    return func
endfunction


" Function : s:ParseClass
" Purpose  :
" Args     :
" Returns  :
" Author   : TANGUY Arnaud
function s:ParseClass()
    let lineBeginning = search('class .*[^;]\n')
    if (lineBeginning < 1)
        return
    endif
    call search("{")
    exe "normal %"
    let lineEnding = line(".")
    let g:implemented_func_list = []
    let i = lineBeginning
    while i < lineEnding
        let line = getline(i)
        if (line =~ '.*(.*).*;.*')
            let g:implemented_func_list += [s:ParseFunction(line)]
        endif
        let i += 1
    endwhile
endfunction

" Function : s:WriteFunctions
" Purpose  :
" Args     :
" Returns  :
" Author   : TANGUY Arnaud
function s:WriteFunctions()
    for i in g:implemented_func_list
        echomsg i
    TgTgt
    endfor
endfunction

if (!exists(":Implement"))
    com! -nargs=0 Implement   call s:ParseClass()
else
    com! -nargs=0 MyImplement  call s:ParseClass()
endif
com! -nargs=0 WriteImplement  call s:WriteFunctions()

let &cpo=s:cpo_save
