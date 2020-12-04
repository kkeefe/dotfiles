# If you come from bash you might have to change your $PATH.
# export PATH=/usr/bin:/usr/local/bin:$PATH
#
# Path to your oh-my-zsh installation.
export ZSH="/Users/kevinkeefe/.oh-my-zsh"

# path things required by homebrew..
export PATH="/usr/local/sbin:$PATH"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# this is the default zsh theme..

# themes you want to use
# ZSH_THEME="robbyrussell"
ZSH_THEME="dracula"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# User configuration
plugins=(git)
source $ZSH/oh-my-zsh.sh

# things we need to do for root
# source ~/Documents/root_build/root-6.20.00-build/bin/thisroot.sh
# export LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH
# export DYLD_LIBRARY_PATH=$ROOTSYS/lib:$DYLD_LIBRARY_PATH

# extra root things if using root via brew:
# really just runs /usr/local/bin/thisroot.sh
# pushd $(brew --prefix) >/dev/null; . bin/thisroot.sh; popd >/dev/null

# # this is required to automatically set geant4 in the path variable..
# # Zsh does not allow the remote sourcing the geant4, for whatever reason.. (this required the cd step..)
# cd ~/Documents/geant4/geant4-build/
# source geant4make.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# doom stuff from the lord hisself
export PATH=$HOME/.emacs.d/bin:$PATH

# llvm / rtags notes received after 'brew install rtags':
# ao use the bundled libc++ please add the following LDFLAGS:
# export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"

# llvm is keg-only, which means it was not symlinked into /usr/local,
# because macOS already provides this software and installing another version in
# parallel can cause all kinds of trouble.

# If you need to have llvm first in your PATH run:
# echo 'export PATH="/usr/local/opt/llvm/bin:$PATH"' >> ~/.zshrc

# For compilers to find llvm you may need to set:
# export LDFLAGS="-L/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/llvm/include"

# To have launchd start rtags now and restart at login:
#   brew services start rtags
# Or, if you don't want/need a background service you can just run:
#   /usr/local/bin/rdm --verbose --inactivity-timeout=300 --log-file=/usr/local/var/log/rtags.log

# set when we're not savages
# set -o vi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# my aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

# alias some useful things over to the s-box..
# keep in mind these ssh values will onyl work if you're connected to the physics network..
alias sync_p_lappd="rsync -rqazhe 'ssh -p 2726' ~/Documents/lappd p@svsc-a-w109.phys.hawaii.edu:/home/p/"
alias sync_p="rsync -rqazhe 'ssh -p 2726' ~/Documents/py_Basic p@svsc-a-w109.phys.hawaii.edu:/home/p/Documents/"
alias ssh_p="ssh -p 2726 p@svsc-a-w109.phys.hawaii.edu -L 4444:192.168.153.25:3121"
alias ssh_p_X="ssh -X -p 2726 p@svsc-a-w109.phys.hawaii.edu -L 4444:192.168.153.25:3121"
alias ssh_p_get_png="rsync -rqazhe 'ssh -p 2726' p@svsc-a-w109.phys.hawaii.edu:/home/p/lappd/test_dir/ ~/Documents/lappd/test_dir/"
alias py="cd ~/Documents/py_Basic/"
alias cpp="cd ~/Documents/basic_C/"
alias work3="cd ~/Documents/SVSC-Work-Stations/Workstation3/"
alias irs="cd ~/Documents/SVSC-Work-Stations/Workstation3/svsc_irs/"
alias gui="cd ~/Documents/eevee/"
alias doc="cd ~/Documents"
alias kill1="kill %1"
alias view5="root -l \"svsc_plot_waveforms_array.cpp(\"IrsBoard@10.0.5.69_pedestal_thread.root\",\"IrsBoard@10.0.5.69_pedestal_thread.txt\")\""
alias view4="root -l \"svsc_plot_waveforms_array.cpp(\"IrsBoard@10.0.4.69_pedestal_thread.root\",\"IrsBoard@10.0.4.69_pedestal_thread.txt\")\""
alias proj="cd ~/Documents/ntc_firmware/firmware/projectSrc/"
alias ssh2="ssh -X ntcuser@168.105.242.250"
alias ssh3="ssh -Y ntcuser@168.105.234.62"
# for updating x11 for the mtc machine:
# $: defaults write org.macosforge.xquartz.X11 enable_iglx -bool true
alias mtc="ssh -Y -p 25260 kevinpk@mtc-b.phys.hawaii.edu"
# alias mtc="ssh -p 25260 kevinpk@mtc-b.phys.hawaii.edu"

export HISTCONTROL=ignoredups
export HISTSIZE=10000

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
