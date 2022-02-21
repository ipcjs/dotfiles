# vi $ZSH_CUSTOM/themes/git-bash.zsh-theme
PROMPT='%{$fg[green]%}%n@%m %{$fg[yellow]%}%~%{$reset_color%} $(git_prompt_info)
$ '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

