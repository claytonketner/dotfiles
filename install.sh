yellow='\033[1;33m'
NC='\033[0m' # No Color

for FILENAME in .*
do
    if [ $FILENAME = . ] || [ $FILENAME = .. ] ; then
        continue
    fi
    if [ -f "$FILENAME" ] || [ $FILENAME != .git ] ; then
        CURRENT_DIR=`pwd -P`
        echo -e "${yellow}For $FILENAME${NC}"
        # -h == symbolic link (linked file doesn't have to exist)
        if [ -h ~/$FILENAME ] ; then
            echo -e "\t- Deleting old symlink"
            rm ~/$FILENAME
        fi
        echo -e "\t+ Creating symlink"
        ln -s $CURRENT_DIR/$FILENAME ~/$FILENAME
    fi
done

echo "Installing vim plugins..."
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
git clone git://github.com/tpope/vim-fugitive.git
vim -u NONE -c "helptags vim-fugitive/doc" -c q
git clone git://github.com/tpope/vim-surround.git
git clone git://github.com/tpope/vim-repeat.git
