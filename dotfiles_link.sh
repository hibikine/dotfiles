#!/bin/sh
ln -sf ~/dotfiles/.vimrc ~/.vimrc
mkdir -v -p ~/.vim/rc
ln -sf ~/dotfiles/dein.toml ~/.vim/rc
ln -sf ~/dotfiles/dein_lazy.toml ~/.vim/rc
if [ "$(uname)" == 'Darwin' ]; then
    OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ] || [ "$(expr substr $(uname -s) 1 9)" == 'CYGWIN_NT' ]; then
    OS='Cygwin'
else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi

if [ $OS == 'Cygwin' ]; then
    echo "Your platform is Cygwin."
fi
