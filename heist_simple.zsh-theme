# heist.zsh-theme

PROMPT='╭─%{$fg_bold[yellow]%}%D{%Y-%m-%d %H:%M:%S} %{$fg[white]%}|%{$reset_color%} %{$fg_bold[green]%}%n@%m %{$fg[white]%}|%{$reset_color%} %{$fg_bold[cyan]%}%~%{$reset_color%} %{$fg[white]%}|%{$reset_color%}
╰─%{$fg_bold[yellow]%}>%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}[%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[white]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%} %{$fg[red]%}✗%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%} %{$fg[green]%}✔%{$fg[white]%}"