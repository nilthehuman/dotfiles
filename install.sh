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
    "${HOME}/.config"
    "${HOME}/.config/openbox"
    "${HOME}/.config/terminator"
    "${HOME}/.ghc"
    "${HOME}/.vim"
    "${HOME}/.vim/after"
    "${HOME}/.vim/after/ftplugin"
)
declare -A links=(
    ["${DOTFILESDIR}/bash/bash_aliases"]                    = "${HOME}/.bash_aliases"
    ["${DOTFILESDIR}/bash/bashrc"]                          = "${HOME}/.bashrc"
    ["${DOTFILESDIR}/ghc/ghci.conf"]                        = "${HOME}/.ghc/ghci.conf"
    ["${DOTFILESDIR}/git/gitconfig"]                        = "${HOME}/.gitconfig"
    ["${DOTFILESDIR}/openbox/rc.xml"]                       = "${HOME}/.config/openbox/rc.xml"
    ["${DOTFILESDIR}/openbox/autostart"]                    = "${HOME}/.config/openbox/autostart"
    ["${DOTFILESDIR}/terminator/config"]                    = "${HOME}/.config/terminator/config"
    ["${DOTFILESDIR}/vim/vimrc"]                            = "${HOME}/.vim/vimrc"
    ["${DOTFILESDIR}/vim/after/ftplugin/formatoptions.vim"] = "${HOME}/.vim/after/ftplugin/formatoptions.vim"
)

for linkdir in "${linkdirs[@]}"; do
    mkdir -p $linkdir;
done
for dotfile in "${!links[@]}"; do
    ln -s $dotfile ${links["$dotfile"]};
done

echo "Done."

