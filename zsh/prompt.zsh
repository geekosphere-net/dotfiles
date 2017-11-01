#
# Set PWD and GIT info

PROMPT='%{$fg[yellow]%}$(_fishy_collapsed_wd)%{$reset_color%}%(?,%{$fg_bold[green]%},%{$fg_bold[red]%})}%{$reset_color%} '

RPROMPT='%{$fg[yellow]%}$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

