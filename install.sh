#!/bin/bash

if [ "$BASH_VERSINFO" -lt 4 ]; then
    echo "You need bash 4 to run this script."
    exit -1;
fi

echo "This script will create symlinks in your ~ directory"
echo "to the files in the dotfiles directory."
read -p "Do you wish to proceed? (Y/n) " USERINPUT
if [ "$USERINPUT" != "Y" ]; then
    echo "Abort."
    exit 0;
fi

DOTFILESDIR=`dirname $0`
DOTFILESDIR=`readlink -f $DOTFILESDIR` # get absolute path

declare -A links=(
    ["${DOTFILESDIR}/bash_aliases"]="~/.bash_aliases"
    ["${DOTFILESDIR}/gitconfig"]="~/.gitconfig"
    ["${DOTFILESDIR}/vimrc"]="~/.vim/vimrc"
)

mkdir -p ~/.vim
for dotfile in "${!links[@]}"; do
    ln -s $dotfile ${links["$dotfile"]};
done

echo "Done."

