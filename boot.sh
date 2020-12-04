#!/usr/bin/env bash
set -o pipefail
# comming from README.org in dotfiles babel export

function link_dotfiles() {
# get the dest and src paths first;
dstPath="$1"; shift;
srcPath="$1"; shift;
# move every file to the backup, and prompt user
files=("$@")
for val in "${files[@]}"
do
    # place where the file should live
    dst="$dstPath""$val"
    # if it's not a symlink already, move it
    if [[ -L "$dst" ]]; then
        echo  "$val" ", is already linked.."
    elif [[ -f "$dst" ]]; then
        file="$(pwd)""$srcPath""$val"
        mv "$dst" "$(pwd)""/backup/"
        echo 'backuping up file:  '  "$val"
        ln -s "$file" "$dstPath"
    else
        echo 'no original source file: ' "$val$"
    fi
done
}

# wsl windows dependencies for ROOT and emacs..
function sudoUpdates(){
sudo apt update
sudo apt upgrade
sudo apt install python3-pip
sudo apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev python openssl-dev
sudo apt-get install openssl-dev
sudo apt install unzip
sudo apt install llvm
sudo apt-get install clangd-9
sudo apt-get install -y shellcheck
sudo apt install glslang-tools
sudo apt-get install -y markdown
sudo apt install fdclone
sudo apt-get install sqlite3 libsqlite3-dev
sudo apt-get install jq
sudo apt-get install graphviz
}

## getting homebrew
function getBrew() {
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

pip3 install numpy matplotlib pytest scipy

# if it's not already there, then clone it down
if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME"/.vim/bundle/Vundle.vim
fi

## Vim config
# the files that should be in our doom path
vimFiles=("vimrc" "viminfo")
vimPath="$HOME""/.vim/"
srcPath="/modules/vim/"
# vim might not have a .vim directory in $HOME at this point, and may use a 'naked' .vimrc, let's fix that here:
if [[ ! -d "$HOME/.vim" ]]; then
    echo "no default vim directory.."
elif [[ -f "$HOME/.vimrc" ]]; then
    echo  "vimrc stored in home.. moving to backup.."
    mv "$HOME/.vimrc" "$(pwd)""/backup/vimrc"
fi
# move every file to the backup, and prompt user
link_dotfiles "$vimPath" "$srcPath" "${vimFiles[@]}"

## Emacs config
# the files that should be in our doom path
emacsFiles=("init.el" "config.el" "packages.el" "custom.el")
doomPath="$HOME""/.doom.d/"
emacsPath="/modules/emacs/"
# move every file to the backup, and prompt user
link_dotfiles "$doomPath" "$emacsPath" "${emacsFiles[@]}"
