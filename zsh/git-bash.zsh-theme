# vi $ZSH_CUSTOM/themes/git-bash.zsh-theme
case "$(arch)" in
    arm64 | x86_64)
        __prompt_arch=""
        ;;
    *)
        __prompt_arch="($(arch))"
        ;;
esac

PROMPT='%{$fg[green]%}%n@%m$__prompt_arch %{$fg[yellow]%}%~%{$reset_color%} $(git_prompt_info)
$ '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
