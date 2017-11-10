if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

export LANG=en_US.UTF-8
export EDITOR=vim
export TERM=xterm-256color
#
# Colors
#
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#
# PATHs
#
export PATH=$PATH:~/bin
export WORKON_HOME=~/.envs
mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh
#
# Other
#
# Git autocompletion
if [ -f ~/dots/.git-completion.bash ]; then
    . ~/dots/.git-completion.bash
fi
# Global git ignore
git config --global core.excludesfile ~/dots/.gitignore
