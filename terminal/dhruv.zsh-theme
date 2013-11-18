# vim:ft=zsh ts=2 sw=2 sts=2
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
RESET_COLOR=$reset_color

# Virtualenv: current working virtualenv
function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

PROMPT='%{$fg[yellow]%}[${PWD/#$HOME/~}]%{$reset_color%}%{$fg[cyan]%}[%D{%a, %d %b %I:%M:%S%p}]%{$reset_color%}
%{$fg_bold[red]%}$(virtualenv_info)%{$reset_color%}%{$fg_bold[green]%}%n@%m%{$reset_color%}%{$fg_bold[yellow]%}$ %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_UNMERGED="%{$RED%}UM"
ZSH_THEME_GIT_PROMPT_DELETED="%{$RED%}D"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$YELLOW%}Rn"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$YELLOW%}Mo"
ZSH_THEME_GIT_PROMPT_ADDED="%{$GREEN%}A"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$WHITE%}Un"
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$RED%}(!)"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$RESET_COLOR%}%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$RESET_COLOR%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

RPROMPT='$(git_prompt_info)$(git_prompt_status)%{$RESET_COLOR%}'
