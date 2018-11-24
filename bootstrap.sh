
if [ -z "$_DOTFILES_REPO_DIR" ]; then
    sudo apt-get update
    sudo apt-get install -y git
    git clone https://github.com/ipcjs/dotfiles.git
    _DOTFILES_REPO_DIR=$(pwd)/dotfiles
fi

if [ -z "$_INIT_SH_LOADED" ]; then
    echo "source $_DOTFILES_REPO_DIR/etc/init.sh" >> ~/.bashrc
    source ~/.bashrc
fi

chmod +x _DOTFILES_REPO_DIR/bin/lg
chmod +x _DOTFILES_REPO_DIR/bin/z.sh