#!/bin/bash

if [ "$BASH_VERSINFO" -lt 4 ]; then
    echo "You need bash 4 to run this script."
    exit -1;
fi

if [[ -t 0 ]]; then
    echo "This script will create symlinks in your ~ directory"
    echo "to the files in the dotfiles directory."
    read -p "Do you wish to proceed? (y/N) " USERINPUT
    if [ "$USERINPUT" != "y" ]; then
        unset USERINPUT
        echo "Abort."
        exit 0;
    fi
fi

DOTFILESDIR=`dirname $0`
DOTFILESDIR=`readlink -f $DOTFILESDIR` # get absolute path

declare -a linkdirs=(
    "${HOME}/.config"
    "${HOME}/.config/dmenu"
    "${HOME}/.config/openbox"
    "${HOME}/.config/terminator"
    "${HOME}/.ghc"
    "${HOME}/.vim"
)
declare -A links=(
    ["${DOTFILESDIR}/bash/bash_aliases"]="${HOME}/.bash_aliases"
    ["${DOTFILESDIR}/bash/bashrc"]="${HOME}/.bashrc"
    ["${DOTFILESDIR}/bash/profile"]="${HOME}/.profile"
    ["${DOTFILESDIR}/compton/compton.conf"]="${HOME}/.config/compton.conf"
    ["${DOTFILESDIR}/conky/conkyrc"]="${HOME}/.conkyrc"
    ["${DOTFILESDIR}/dmenu/dmenu-bind.sh"]="${HOME}/.config/dmenu/dmenu-bind.sh"
    ["${DOTFILESDIR}/eslint/eslintrc"]="${HOME}/.eslintrc"
    ["${DOTFILESDIR}/ghc/ghci.conf"]="${HOME}/.ghc/ghci.conf"
    ["${DOTFILESDIR}/git/gitconfig"]="${HOME}/.gitconfig"
    ["${DOTFILESDIR}/jshint/jshintrc"]="${HOME}/.jshintrc"
    ["${DOTFILESDIR}/openbox/rc.xml"]="${HOME}/.config/openbox/rc.xml"
    ["${DOTFILESDIR}/openbox/autostart"]="${HOME}/.config/openbox/autostart"
    ["${DOTFILESDIR}/terminator/config"]="${HOME}/.config/terminator/config"
    ["${DOTFILESDIR}/vim/vimrc"]="${HOME}/.vim/vimrc"
)

for linkdir in "${linkdirs[@]}"; do
    mkdir -p $linkdir;
done
for dotfile in "${!links[@]}"; do
    ln -s $dotfile ${links["$dotfile"]};
done

unset USERINPUT DOTFILESDIR linkdirs links linkdir dotfile

echo "Done."

