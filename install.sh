#!/bin/bash

yellow='\033[1;33m'
NC='\033[0m'  # No Color
BASHRC_SNIPPET="if [[ -f ~/dots/.bashrc ]]; then source ~/dots/.bashrc; fi";
BASH_PROFILE_SNIPPET="if [[ -f ~/dots/.bash_profile ]]; then source ~/dots/.bash_profile; fi";

echo "Installing files to home directory..."
for FILENAME in *
do
    if [[ $FILENAME = . ]] || [[ $FILENAME = .. ]] || [[ $FILENAME = .git ]]; then
        continue
    fi
    if [[ -d $FILENAME ]]; then
        CURRENT_DIR=`pwd -P`
        echo -e "${yellow}For $FILENAME:${NC}"
        # -h == symbolic link (linked file doesn't have to exist)
        if [[ -h ~/$FILENAME ]] ; then
            echo -e "\t  Symlink already exists"
	else
            echo -e "\t+ Creating symlink"
            ln -s $CURRENT_DIR/$FILENAME ~/$FILENAME
        fi
    fi
done

if ! $(fgrep -q "$BASHRC_SNIPPET" ~/.bashrc); then
    echo "Adding \"$BASHRC_SNIPPET\" to ~/.bashrc"
    echo $BASHRC_SNIPPET >> ~/.bashrc
else
    echo "Leaving bashrc as is."
fi
if ! $(fgrep -q "$BASH_PROFILE_SNIPPET" ~/.bash_profile); then
    echo "Adding \"$BASH_PROFILE_SNIPPET\" to ~/.bash_profile"
    echo $BASH_PROFILE_SNIPPET >> ~/.bash_profile
else
    echo "Leaving bash_profile as is."
fi

if [[ `git --version` == *"1.7"* ]]; then
    echo "Detected old git version that doesn't support includes."
    echo "Appending dots/.gitconfig to ~/.gitconfig"
    echo dots/.gitconfig >> ~/.gitconfig
    sed -i 's/default = simple/default = upstream/' ~/.gitconfig
fi

echo "Installing tmux tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Installing vim plugins..."
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-fugitive.git
vim -u NONE -c "helptags vim-fugitive/doc" -c q
git clone git://github.com/tpope/vim-surround.git
git clone git://github.com/tpope/vim-repeat.git
git clone git@github.com:nvie/vim-flake8.git
git clone git@github.com:elzr/vim-json.git
# Hackfix for vim-flake8 -- see https://github.com/nvie/vim-flake8/issues/13
ln -s ~/.vim/bundle/vim-flake8/ftplugin/ ~/.vim/bundle/vim-flake8/plugin
