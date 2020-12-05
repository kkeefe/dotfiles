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
    file="$(pwd)""$srcPath""$val"
    # if it's not a symlink already, move it
    if [[ -L "$dst" ]]; then
        echo  "$val" ", is already linked.."
    elif [[ -f "$dst" ]]; then
        mv "$dst" "$(pwd)""/backup/"
        echo 'backuping up file: '  "$val"
        ln -s "$file" "$dstPath"
    else
        echo 'no original source file: ' "$val"
        ln -s "$file" "$dstPath"
    fi
done
}

## wsl windows dependencies for ROOT and emacs..
function sudoUpdates(){
    sudo apt update
    sudo apt upgrade
    sudo apt install python3-pip
    # required dependencies
    sudo apt-get install git ripgrep
    # optional dependencies
    sudo apt-get install fd-find
    sudo apt-get install direnv
    sudo apt-get install spell
    sudo apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev python openssl-dev
    sudo apt-get install openssl-dev
    sudo apt install unzip
    sudo apt install llvm
    sudo apt-get install clangd-9
    sudo apt-get install -y shellcheck
    sudo apt install glslang-tools
    sudo apt install fdclone
    sudo apt-get install sqlite3 libsqlite3-dev
    sudo apt-get install jq
    sudo apt-get install graphviz
}

## getting homebrew
function getBrew() {
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}
function makeBrew() {
    brew install zsh
    brew install git
    brew install ripgrep
    brew install coreutils
    brew install fd
    brew install python3
    brew install llvm
    brew cask install iterm2
    brew install glslang
    brew install jq
    brew install qt5
    brew install tmux
    brew install xerxes-c
    # emacs based on doom config
    brew tap d12frosted/emacs-plus
    brew install emacs-plus
    ln -s /usr/local/opt/emacs-plus/Emacs.app /Applications/Emacs.app
    # root last
    brew install root
}
function getOhMyZsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    upgrade_oh_my_zsh
}

pip3 install numpy matplotlib pytest scipy isort pipenv nose pandas tensorflow

shellFiles=(".bashrc" ".bash_profile")
shellPath="$HOME" # shell files are directly at home..
srcPath="/modules/shell/"
# expect either zsh, or bashrc.. prefer zsh..
if [[ -f "$HOME/.zshrc" ]]; then
    echo  "zshrc stored in home.. configuring zsh.."
    shellFiles=(".zshrc" ".zprofile")
elif [[ -f "$HOME/.bashrc" ]]; then
    echo  "bashrc stored in home.. configuring bash.."
else
    echo "no bash or zsh found.. linking bash for safety"
fi
# move every file to the backup, and prompt user
link_dotfiles "$shellPath/" "$srcPath" "${shellFiles[@]}"

# if it's not already there, then clone it down
if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME"/.vim/bundle/Vundle.vim
fi

## Vim conf ig
# the files that should be in our doom path
vimFiles=("vimrc" "viminfo")
vimPath="$HOME""/.vim/"
srcPath="/modules/vim/"
# vim might not have a .vim directory in $HOME at this point, and may use a 'naked' .vimrc, let's fix that here:
if [[ -f "$HOME/.vimrc" ]]; then
    echo  "vimrc stored in home.. moving to backup.."
    mv "$HOME/.vimrc" "$(pwd)""/backup/vimrc"
fi
# move every file to the backup, and prompt user
link_dotfiles "$vimPath" "$srcPath" "${vimFiles[@]}"

function getDoom(){
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
}

## Emacs config
# the files that should be in our doom path
emacsFiles=("init.el" "config.el" "packages.el" "custom.el")
doomPath="$HOME""/.doom.d/"
emacsPath="/modules/emacs/"
# move every file to the backup, and prompt user
link_dotfiles "$doomPath" "$emacsPath" "${emacsFiles[@]}"
