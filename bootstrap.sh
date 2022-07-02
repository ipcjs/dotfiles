#!/bin/bash
rc_file=~/.bashrc
if [ -n "$ZSH_VERSION" ]; then
    rc_file=~/.zshrc
elif [ "$(uname -s)" == "Darwin" ]; then
    # macOS+bash
    rc_file=~/.bash_profile
fi
CUR_DIR=$(pwd)

_install=""
while test $# -gt 0; do
    case "$1" in
        install)
            _install="true"
            ;;
        *)
            echo "unknown arg: $1"
            echo "usage: $0 [install]"
            echo "  install: force install"
            exit 1
            ;;
    esac
    shift
done

if [ -z "$DOTFILES_REPO_DIR" ]; then
    echo '==clone dotfiles repo...'
    if [ -z "$(which git)" ]; then
        sudo apt-get update
        sudo apt-get install -y git
    fi
    # config git alias
    git --version
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"
    git config --global alias.lga "log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"

    if [ "$(basename "$(pwd)")" = "dotfiles" ]; then
        DOTFILES_REPO_DIR=$(pwd)
    else
        echo '==clone dofiles repo...'
        git clone --recursive https://github.com/ipcjs/dotfiles.git
        DOTFILES_REPO_DIR=$(pwd)/dotfiles
    fi
    _install="true"
else
    echo '==update dofiles repo...'
    cd "$DOTFILES_REPO_DIR" || exit 1
    git pull && git submodule update --init --recursive || return 1 2>/dev/null || exit 1
fi

if [ -n "$_install" ]; then
    echo '==config...'
    if [ -n "$ZSH_VERSION" ]; then
        echo '==config zsh...'
        if [ -z "$ZSH" ]; then
            echo '==install oh-my-zsh...'
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            if [ ! -d "$HOME/.oh-my-zsh" ]; then
                echo "==install failed..." && return 1 2>/dev/null || exit 1
            fi
        fi
        # ensure omz is installed, then update .zshrc
        echo "export DOTFILES_REPO_DIR=$DOTFILES_REPO_DIR" >>$rc_file

        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        cp "$DOTFILES_REPO_DIR/zsh/git-bash.zsh-theme" ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/
        # shellcheck disable=SC2016
        {
            echo 'source $DOTFILES_REPO_DIR/zsh/config'
            echo
            echo 'source $ZSH/oh-my-zsh.sh'
        } >>$rc_file
        echo 'delete old zsh variable by yourself. Enter to continue...'
        read -r
        vi $rc_file
    else
        echo "export DOTFILES_REPO_DIR=$DOTFILES_REPO_DIR" >>$rc_file
    fi
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
cd "$CUR_DIR" || exit 1
unset CUR_DIR
# shellcheck disable=SC1090
source "$rc_file"
