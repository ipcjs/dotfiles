# 定义自动完成函数
# Write by ChatGPT
__github_flow_branch_complete() {
    # 获取所有分支名
    local branches=$(git branch | cut -c 3-)

    # 当前输入的内容
    local cur="${COMP_WORDS[COMP_CWORD]}"

    # 根据当前输入的内容，过滤分支名
    COMPREPLY=($(compgen -W "${branches}" -- ${cur}))
}

# 给脚本添加自动完成功能
complete -F __github_flow_branch_complete github-flow
