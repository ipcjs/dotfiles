# ipcjs's dotfiles

## Install

```sh
source <(curl https://raw.githubusercontent.com/ipcjs/dotfiles/master/bootstrap.sh)
```

## Update

```sh
# 由于要检测各种变量是否存在, 故需要用source, 在当前环境中执行
git pull & source bootstrap.sh
```

## 参考

1. [提高效率从编写 init.sh 开始 - 知乎](https://zhuanlan.zhihu.com/p/50080614)
2. [终端效率提升：自动路径切换 - 知乎](https://zhuanlan.zhihu.com/p/50548459)
3. [hanxi/dotfiles: bash + tmux + neovim](https://github.com/hanxi/dotfiles)