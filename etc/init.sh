#!/bin/bash
echo "source $DOTFILES_REPO_DIR/etc/init.sh"

# 交互式模式的初始化脚本, 防止被加载两次
if [ -z "$_INIT_SH_LOADED" ]; then
    _INIT_SH_LOADED=1
else
    return
fi

# 如果是非交互式则退出，比如 bash test.sh 这种调用 bash 运行脚本时就不是交互式; 只有直接敲 bash 进入的等待用户输入命令的那种模式才成为交互式，才往下初始化
case "$-" in
    *i*) ;;
    *) return ;;
esac

# export _INIT_SH_LOADED

# add bin to PATH
export PATH="$DOTFILES_REPO_DIR/bin:$PATH"

# 整理 PATH，删除重复路径
if [ -n "$PATH" ]; then
    old_PATH=$PATH:
    PATH=
    while [ -n "$old_PATH" ]; do
        x=${old_PATH%%:*}
        case $PATH: in
            *:"$x":*) ;;
            *) PATH=$PATH:$x ;;
        esac
        old_PATH=${old_PATH#*:}
    done
    PATH=${PATH#:}
    unset old_PATH x
fi

export PATH

alias cnpm='npm --registry=https://registry.npm.taobao.org'
alias cyarn='yarn --registry=https://registry.npm.taobao.org'
alias cpnpm='pnpm --registry=https://registry.npm.taobao.org'

if ! type l >/dev/null 2>&1; then
    alias l='ls -al'
fi

# flutter
# export PUB_HOSTED_URL=https://pub.flutter-io.cn
unset PUB_HOSTED_URL
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
alias fp='flutter pub'
alias fpx='flutter pub run'
alias fpget='flutter pub get'
alias cfpget='PUB_HOSTED_URL=https://pub.flutter-io.cn flutter pub get'
alias cflutter='PUB_HOSTED_URL=https://pub.flutter-io.cn flutter'
alias cflutter+='PUB_HOSTED_URL=https://pub.flutter-io.cn flutter+'

function sc() {
    target=$1
    cmd=$2
    sudo systemctl $cmd $target
}

function is-wsl-2() {
    uname -r | grep WSL2 >/dev/null 2>&1
}

function dotfiles_update() {
    cd "$DOTFILES_REPO_DIR" || return 1
    git pull --rebase && git submodule update --init --recursive || return 1
    cd - || return 1

    source "$DOTFILES_REPO_DIR/bootstrap.sh"
}
