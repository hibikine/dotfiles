#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue

    echo $f
    if [ -d "${f}" ]; then
      ln -sf $SCRIPT_DIR/$f/ ~/$f
    else
      ln -sf $SCRIPT_DIR/$f ~/$f
    fi
done

ln -sf $SCRIPT_DIR/.gitconfig ~/.gitconfig
mkdir -p ~/.config/nvim
ln -sf $SCRIPT_DIR/init.vim ~/.config/nvim/init.vim

# declare OS
if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
fi

# install vscode setting file
case $OS in
    "Mac")
        ln -sf $SCRIPT_DIR/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
        echo "VSCode setting file was installed."
        ;;
    "Linux")
        ln -sf $SCRIPT_DIR/vscode/linux-settings.json $HOME/.config/Code/User/settings.json
        ln -sf $SCRIPT_DIR/vscode/linux-keybindings.json $HOME/.config/Code/User/keybindings.json
        echo "VSCode setting file was installed."
        ;;
    *)
        echo "this os does not supported to install vscode setting file by this script."
        ;;
esac

