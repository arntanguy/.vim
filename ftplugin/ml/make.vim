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

let s:cpo_save=&cpo
set cpo&vim

" Do not reload if already loaded
if exists('g:loaded_ml_make_plugin')
  \ && !exists('g:force_reload_ml_make_plugin')
   finish
endif
let g:loaded_ml_make_plugin= 1
"
" Global variables initialisation (if not already set)
if !exists('g:quickfix_size')
    let g:quickfix_size=6
endif

" Function : s:MlMake
" Author   : TANGUY Arnaud
function s:MlMake()
    echo "MlMake called"
    if (mode()  == "v" || mode() == "V")
        let txt=getreg("*") 
       let &makeprg="echo ".txt." |camllight"
    else
       let &makeprg="!cat ".expand("%:p")." |camllight"
    endif
   echomsg "Make prg: ".&makeprg
    " Save the old directory, and go to the new one
    exe &makeprg
1;3R
endfunction

" Function : s:MlMake
" Author   : TANGUY Arnaud
function s:VMlMake()
   let txt=getreg("*") 
   let &makeprg="!echo '".txt."' |camllight"
   echomsg "Make prg: ".&makeprg
    " Save the old directory, and go to the new one
    exe &makeprg
endfunction

com! -nargs=0 Mm call s:MlMake()
com! -nargs=0 VMm call s:VMlMake()

let &cpo=s:cpo_save
