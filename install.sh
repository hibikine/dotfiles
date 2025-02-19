#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
PRIVATE_DOTFILE_DIR="dotfiles-priv"

echo "1. Copy dotfiles"
echo ""

for f in .??*
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    [[ "$f" == ".travis.yml" ]] && continue
    [[ "$f" == ".circleci" ]] && continue
    [[ "$f" == ".github" ]] && continue
    [[ "$f" == ".config" ]] && continue

    echo $f
    if [ -d "${f}" ]; then
        ln -sf $SCRIPT_DIR/$f/ ~/$f
    else
        ln -sf $SCRIPT_DIR/$f ~/$f
    fi
done

echo ".config/nvim"
ln -sf $SCRIPT_DIR/nvim/ ~/.config/nvim

echo "done."
echo ""

if [ -d "$PRIVATE_DOTFILE_DIR" ]; then
    echo "1.1 Copy private dotfiles"
    echo ""

    for f in $PRIVATE_DOTFILE_DIR/.??*
    do
        [[ "$f" == "$PRIVATE_DOTFILE_DIR/.git" ]] && continue
        echo ${f#$PRIVATE_DOTFILE_DIR/}
        if [ -d "${f}" ]; then
            ln -sf $SCRIPT_DIR/$f/ ~/${f#$PRIVATE_DOTFILE_DIR/}
        else
            ln -sf $SCRIPT_DIR/$f ~/${f#$PRIVATE_DOTFILE_DIR/}
        fi
    done
    echo "done."
    echo ""
fi

echo "2. Copy pet settings"
echo ""

mkdir -p ~/.config/pet
ln -sf $SCRIPT_DIR/.config/pet/config.toml ~/.config/pet/config.toml
ln -sf $SCRIPT_DIR/.config/pet/snippet.toml ~/.config/pet/snippet.toml

echo "done."
echo ""

echo "3. Copy gitconfig"
echo ""

ln -sf $SCRIPT_DIR/.gitconfig ~/.gitconfig
mkdir -p ~/.config/nvim
mkdir -p ~/.vim/tmp

echo "done."
echo ""

# declare OS
if [ "$(uname)" == 'Darwin' ]; then
    OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
    OS='Cygwin'
fi

# install vscode setting file
echo "4. Install vscode settings (if needed)"
echo ""

if [ -d $SCRIPT_DIR/dotfiles-priv ]; then
    case $OS in
        "Mac")
            ln -sf $SCRIPT_DIR/dotfiles-priv/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
            ln -sf $SCRIPT_DIR/dotfiles-priv/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
            rm -rf $HOME/Library/Application\ Support/Code/User/snippets
            ln -sf $SCRIPT_DIR/dotfiles-priv/vscode/snippets $HOME/Library/Application\ Support/Code/User/
            echo "VSCode setting file was installed."
            ;;
        "Linux")
            mkdir -p $HOME/.config/Code/User
            ln -sf $SCRIPT_DIR/dotfiles-priv/vscode/linux-settings.json $HOME/.config/Code/User/settings.json
            ln -sf $SCRIPT_DIR/dotfiles-priv/vscode/linux-keybindings.json $HOME/.config/Code/User/keybindings.json
            rm -rf $HOME/.config/Code/User/snippets
            ln -sf $SCRIPT_DIR/dotfiles-priv/vscode/snippets $HOME/.config/Code/User/
            echo "VSCode setting file was installed."
            ;;
        *)
            echo "this os does not supported to install vscode setting file by this script."
            ;;
    esac
else
    echo "There is not private dotfiles folder. Please install by the command:"
    echo "git submodule update --init --recursive"
    echo ""
fi

echo "done."
echo ""

# create local gitconfig
echo "5. create local gitconfig settings"
echo ""
touch ~/.gitconfig.local

echo "done."
echo ""
echo "install script Finished."
echo ""

