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
        if [ -f ~/$FILENAME ] ; then
            echo -e "\t- Deleting old symlink"
            rm ~/$FILENAME
        fi
        echo -e "\t+ Creating symlink"
        ln -s $CURRENT_DIR/$FILENAME ~/$FILENAME
    fi
done
