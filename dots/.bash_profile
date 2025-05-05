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
export PATH="$PATH:/usr/local/opt/postgresql@9.6/bin"
export WORKON_HOME=~/.envs
export CPPFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib
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

eval "$(pyenv init -)"  # brew install pyenv

# Disable OSX alternate character popup when holding a keyboard key
if [[ $(uname) == 'Darwin' ]]; then
    defaults write -g ApplePressAndHoldEnabled -bool false
fi
