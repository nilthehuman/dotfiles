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

declare -a linkdirs=(
    "~/.config"
    "~/.config/openbox"
    "~/.config/terminator"
    "~/.vim"
    "~/.vim/after"
    "~/.vim/after/ftplugin"
)
declare -A links=(
    ["${DOTFILESDIR}/bash/bash_aliases"]="~/.bash_aliases"
    ["${DOTFILESDIR}/bash/bashrc"]="~/.bashrc"
    ["${DOTFILESDIR}/git/gitconfig"]="~/.gitconfig"
    ["${DOTFILESDIR}/openbox/rc.xml"]="~/.config/openbox/rc.xml"
    ["${DOTFILESDIR}/openbox/autostart"]="~/.config/openbox/autostart"
    ["${DOTFILESDIR}/terminator/config"]="~/.config/terminator/config"
    ["${DOTFILESDIR}/vim/vimrc"]="~/.vim/vimrc"
    ["${DOTFILESDIR}/vim/after/ftplugin/formatoptions.vim"]="~/.vim/after/ftplugin/formatoptions.vim"
)

for linkdir in "${linkdirs[@]}"; do
    mkdir -p $linkdir;
done
for dotfile in "${!links[@]}"; do
    ln -s $dotfile ${links["$dotfile"]};
done

echo "Done."

