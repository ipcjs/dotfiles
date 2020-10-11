#!/bin/bash
rc_file=~/.bashrc
if [ -n "$ZSH_VERSION" ]; then
    rc_file=~/.zshrc
fi
CUR_DIR=$(pwd)
if [ -z "$DOTFILES_REPO_DIR" ]; then
    echo '==clone dofiles repo...'
    if [ -z "$(which git)" ]; then
        sudo apt-get update
        sudo apt-get install -y git
    fi
    # config git alias
    git --version
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
    git config --global alias.lga "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"

    git clone https://github.com/ipcjs/dotfiles.git
    DOTFILES_REPO_DIR=$(pwd)/dotfiles
    echo "export DOTFILES_REPO_DIR=$DOTFILES_REPO_DIR" >>$rc_file
else
    echo '==update dofiles repo...'
    cd $DOTFILES_REPO_DIR
    git pull
fi

if [ -z "$_INIT_SH_LOADED" ]; then
    echo '==install init.sh...'
    echo "source $DOTFILES_REPO_DIR/etc/init.sh" >>$rc_file
else
    unset _INIT_SH_LOADED
fi

if [ -z "$(type -t z)" ]; then
    echo '==install z...'
    echo "source $DOTFILES_REPO_DIR/etc/z.sh" >>$rc_file
fi

# end
cd $CUR_DIR
unset CUR_DIR
source $rc_file
