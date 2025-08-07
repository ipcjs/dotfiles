# ipcjs's dotfiles

## Zsh/Bash

### Install

```sh
# 推荐使用zsh执行命令
source <(curl https://raw.githubusercontent.com/ipcjs/dotfiles/master/bootstrap.sh)
```

### Update

```sh
dotfiles_update
```

### WSL1

1. 让WSL和Windows之间透传环境变量, 在Windows中设置`WSLENV`环境变量: `http_proxy:https_proxy:no_proxy:DROPBOX/p:SKIP_USE_EXE:ANDROID_SERIAL:PUB_HOSTED_URL:USERPROFILE/p:ANDROID_SDK_ROOT/p:ELECTRON_MIRROR`

2. 让WSL中无需`.exe`后缀执行Windows上的程序, 在~/.zshrc末尾添加: `source $DOTFILES_REPO_DIR/bin/use-exe`

## Scoop

当前仓库同时也是一个Scoop的bucket, 执行如下命令, 安装它:

```powershell
scoop bucket add ipcjs https://github.com/ipcjs/dotfiles.git
```

## PowerShell

[profile.ps1](pwsh/profile.ps1)是PowerShell的配置文件, 目前没写自动配置脚本, 需要手动配置: [PowerShell配置](https://www.evernote.com/l/AJSPPklXStNG6ZYG9jKKAbZffYUBsgdvT88/)

## 参考

1. [提高效率从编写 init.sh 开始 - 知乎](https://zhuanlan.zhihu.com/p/50080614)
2. [终端效率提升：自动路径切换 - 知乎](https://zhuanlan.zhihu.com/p/50548459)
3. [hanxi/dotfiles: bash + tmux + neovim](https://github.com/hanxi/dotfiles)
