CUR_DIR=$(readlink -f $(pwd))
if [ -z "$_DOTFILES_REPO_DIR" ]; then
    echo ==clone dofiles repo...
    if [ -z $(which git) ]; then
        sudo apt-get update
        sudo apt-get install -y git
    fi
    git clone https://github.com/ipcjs/dotfiles.git
    _DOTFILES_REPO_DIR=$(pwd)/dotfiles
else
    echo ==update dofiles repo...
    cd $_DOTFILES_REPO_DIR
    git pull
fi

if [ -z "$_INIT_SH_LOADED" ]; then
    echo ==install init.sh...
    echo "source $_DOTFILES_REPO_DIR/etc/init.sh" >> ~/.bashrc
else
    unset _INIT_SH_LOADED
fi

if [ -z $(type -t z) ]; then
    echo ==install z...
    echo "source $_DOTFILES_REPO_DIR/etc/z.sh" >> ~/.bashrc
fi

# end
cd $CUR_DIR
unset CUR_DIR
source ~/.bashrc