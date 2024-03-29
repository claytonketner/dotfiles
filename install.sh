#!/bin/bash

yellow='\033[1;33m'
NC='\033[0m'  # No Color
BASHRC_SNIPPET="source ~/dots/.bashrc";
BASH_PROFILE_SNIPPET="source ~/dots/.bash_profile";
TMUX_CONF_SNIPPET="source ~/dots/.tmux.conf"
VIMRC_SNIPPET="source ~/dots/.vimrc"
GITCONFIG_SNIPPET="~/dots/.gitconfig"
GITIGNORE_SNIPPET="~/dots/.gitignore"

echo -e "Beginning install. ${yellow}Changes will be shown in yellow.${NC} (Except some things (nice))"
for FILENAME in *
do
    if [[ $FILENAME = . ]] || [[ $FILENAME = .. ]] || [[ $FILENAME = .git ]]; then
        continue
    fi
    if [[ -d $FILENAME ]]; then
        CURRENT_DIR=`pwd -P`
        # -h == symbolic link (linked file doesn't have to exist)
        if [[ -h ~/$FILENAME ]] ; then
            echo -e "$FILENAME: symlink already exists"
	else
            echo -e "${yellow}$FILENAME: creating symlink${NC}"
            ln -s $CURRENT_DIR/$FILENAME ~/$FILENAME
        fi
    fi
done

if ! $(fgrep -q "$BASHRC_SNIPPET" ~/.bashrc); then
    echo -e "${yellow}Adding \"$BASHRC_SNIPPET\" to ~/.bashrc${NC}"
    echo $BASHRC_SNIPPET >> ~/.bashrc
else
    echo "Leaving bashrc as is."
fi
if ! $(fgrep -q "$BASH_PROFILE_SNIPPET" ~/.bash_profile); then
    echo -e "${yellow}Adding \"$BASH_PROFILE_SNIPPET\" to ~/.bash_profile${NC}"
    echo $BASH_PROFILE_SNIPPET >> ~/.bash_profile
else
    echo "Leaving bash_profile as is."
fi
if ! $(fgrep -q "$TMUX_CONF_SNIPPET" ~/.tmux.conf); then
    touch ~/.tmux.conf
    echo -e "${yellow}Adding \"$TMUX_CONF_SNIPPET\" to ~/.tmux.conf${NC}"
    echo $TMUX_CONF_SNIPPET >> ~/.tmux.conf
else
    echo "Leaving tmux.conf as is."
fi
if ! $(fgrep -q "$VIMRC_SNIPPET" ~/.vimrc); then
    touch ~/.vimrc
    echo -e "${yellow}Adding \"$VIMRC_SNIPPET\" to ~/.vimrc${NC}"
    echo $VIMRC_SNIPPET >> ~/.vimrc
else
    echo "Leaving tmux.conf as is."
fi

if [[ `git --version` == *"1.7"* ]]; then
    echo "Detected old git version that doesn't support includes."
    echo -e "${yellow}Appending dots/.gitconfig to ~/.gitconfig${NC}"
    cat dots/.gitconfig >> ~/.gitconfig
    sed -i 's/default = simple/default = upstream/' ~/.gitconfig
else
	if [[ `git config --global --get-all include.path` != *$GITCONFIG_SNIPPET* ]]; then
		echo -e "${yellow}Adding $GITCONFIG_SNIPPET to global gitconfig${NC}"
		git config --global --add include.path $GITCONFIG_SNIPPET
	fi
	if [[ `git config --global --get-all core.excludesfile` != *$GITIGNORE_SNIPPET* ]]; then
		echo -e "${yellow}Adding $GITIGNORE_SNIPPET to global gitconfig${NC}"
		git config --global --add core.excludesfile $GITIGNORE_SNIPPET
	fi
fi

echo "Installing tmux tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Installing vim plugins..."
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
mkdir -p ~/.vim/pack/tpope/start
cd ~/.vim/pack/tpope/start
git clone https://tpope.io/vim/fugitive.git
vim -u NONE -c "helptags fugitive/doc" -c q
cd ~/.vim/bundle
git clone git@github.com:tpope/vim-surround.git
git clone git@github.com:tpope/vim-repeat.git
git clone git@github.com:tpope/vim-markdown.git
git clone git@github.com:nvie/vim-flake8.git
git clone git@github.com:elzr/vim-json.git
# Hackfix for vim-flake8 -- see https://github.com/nvie/vim-flake8/issues/13
ln -s ~/.vim/bundle/vim-flake8/ftplugin/ ~/.vim/bundle/vim-flake8/plugin
