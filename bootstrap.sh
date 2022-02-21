#!/bin/bash
rc_file=~/.bashrc
if [ -n "$ZSH_VERSION" ]; then
    rc_file=~/.zshrc
elif [ "$(uname -s)" == "Darwin" ]; then
    # macOS+bash
    rc_file=~/.bash_profile
fi
CUR_DIR=$(pwd)

if [ -z "$DOTFILES_REPO_DIR" ]; then
    echo '==config...'
    if [ -z "$(which git)" ]; then
        sudo apt-get update
        sudo apt-get install -y git
    fi
    # config git alias
    git --version
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
    git config --global alias.lga "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"

    if [ "$(basename $(pwd))" = "dotfiles" ]; then
        DOTFILES_REPO_DIR=$(pwd)
    else
        echo '==clone dofiles repo...'
        git clone --recursive https://github.com/ipcjs/dotfiles.git
        DOTFILES_REPO_DIR=$(pwd)/dotfiles
    fi
    echo "export DOTFILES_REPO_DIR=$DOTFILES_REPO_DIR" >>$rc_file

    if [ -n "$ZSH_VERSION" ]; then
        echo '==config zsh...'
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        cp "$DOTFILES_REPO_DIR/zsh/git-bash.zsh-theme" ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/
        # shellcheck disable=SC2016
        {
            echo 'source $DOTFILES_REPO_DIR/zsh/config'
            echo
            echo 'source $ZSH/oh-my-zsh.sh'
        } >>$rc_file
    fi
else
    echo '==update dofiles repo...'
    cd "$DOTFILES_REPO_DIR" || exit 1
    git pull && git submodule update --init --recursive
fi

if [ -z "$_INIT_SH_LOADED" ]; then
    echo '==install init.sh...'
    # shellcheck disable=SC2016
    echo 'source $DOTFILES_REPO_DIR/etc/init.sh' >>$rc_file
else
    unset _INIT_SH_LOADED
fi

if ! type z >/dev/null 2>&1 && [ -z "$ZSH_VERSION" ]; then
    echo '==install z...'
    # shellcheck disable=SC2016
    echo 'source $DOTFILES_REPO_DIR/etc/z.sh' >>$rc_file
fi

# end
cd $CUR_DIR
unset CUR_DIR
source $rc_file
