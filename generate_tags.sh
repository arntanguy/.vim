#!/bin/bash
if [[ ! -d ~/.vim/tags ]]; then
    mkdir ~/.vim/tags
fi
ctags -f ~/.vim/tags/qt4 -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include/qt4
ctags -f ~/.vim/tags/sfml -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include/SFML
