This is my own VIM configuration. Here is some rough reminder for myself. I'll improve it at some point to provide a comprehensive 
install documentation for everyone. Most of it will work out of the box, except the following plugins:

Start vim, and run

  :BundleInstall

Then, go to ~/.vim/bundle and do the following

- YouCompleteMe : General/C++ completion tool. You will have to compile it, run
    ./install.sh

- Powerline: nice status bar
    ./setup build
    sudo ./setup install (necessary if you want to use it with bash)


