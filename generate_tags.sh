#!/bin/bash
rm ~/.vim/tags/*
if [[ ! -d ~/.vim/tags ]]; then
    mkdir ~/.vim/tags
fi

#ctags -f ~/.vim/tags/qt4 -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include/qt4
ctags -f ~/.vim/tags/sfml -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/local/include/SFML
#ctags -f ~/.vim/tags/ogre -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include/OGRE
ctags -f ~/.vim/tags/opencv -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include/opencv2
ctags -f ~/.vim/tags/opengl -R --c++-kinds=+p --fields=+iaS --extra=+q /usr/include/GL
ctags -f ~/.vim/tags/CGEngine -R --c++-kinds=+p --fields=+iaS --extra=+q ~/TCD/CGEngine/src
ctags -f ~/.vim/tags/PHEngine -R --c++-kinds=+p --fields=+iaS --extra=+q ~/TCD/Real-time_Physics/PHEngine/src


