yellow='\033[1;33m'
NC='\033[0m'  # No Color
BASHRC_SNIPPET="if [[ -f ~/.bashrc_shared ]]; then source ~/.bashrc_shared; fi";
BASH_PROFILE_SNIPPET="if [[ -f ~/.bash_profile_shared ]]; then source ~/.bash_profile_shared; fi";

echo "Installing files to home directory..."
for FILENAME in .*
do
    if [[ $FILENAME = . ]] || [[ $FILENAME = .. ]] || [[ $FILENAME = .git ]]; then
        continue
    fi
    if [[ -f $FILENAME ]]; then
        CURRENT_DIR=`pwd -P`
        echo -e "${yellow}For $FILENAME:${NC}"
        # -h == symbolic link (linked file doesn't have to exist)
        if [[ -h ~/$FILENAME ]] ; then
            echo -e "\t- Deleting old symlink"
            rm ~/$FILENAME
        fi
        echo -e "\t+ Creating symlink"
        ln -s $CURRENT_DIR/$FILENAME ~/$FILENAME
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

echo "Installing vim plugins..."
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-fugitive.git
vim -u NONE -c "helptags vim-fugitive/doc" -c q
git clone git://github.com/tpope/vim-surround.git
git clone git://github.com/tpope/vim-repeat.git
git clone git@github.com:nvie/vim-flake8.git
