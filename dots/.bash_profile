if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

export LANG=en_US.UTF-8
export EDITOR=vim
export TERM=xterm
#
# Colors
#
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#
# PATHs
#
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:~/bin"
export PATH="$PATH:$PYENV_ROOT/bin"
export WORKON_HOME=~/.envs
mkdir -p $WORKON_HOME
if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
	source /usr/local/bin/virtualenvwrapper.sh
fi
#
# Other
#
# Git autocompletion
if [ -f ~/dots/.git-completion.bash ]; then
    . ~/dots/.git-completion.bash
fi
# Global git ignore
git config --global core.excludesfile ~/dots/.gitignore

eval "$(pyenv init -)"  # brew install pyenv

# Disable OSX alternate character popup when holding a keyboard key
if [[ $(uname) == 'Darwin' ]]; then
    defaults write -g ApplePressAndHoldEnabled -bool false
fi
