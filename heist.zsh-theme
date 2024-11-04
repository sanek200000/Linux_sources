local delimetr=' %{$fg[white]%}|%{$reset_color%} '

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
local user_host="%B%(!.%{$fg[red]%}.%{$fg[green]%})%n@%m%{$reset_color%}"${delimetr}
local user_symbol='%(!.#.>)'
local current_dir="%B%{$fg[blue]%}%~%{$reset_color%}"${delimetr}
local date_time="%{$fg_bold[yellow]%}%D{%Y-%m-%d %H:%M:%S}${delimetr}"

local git='$(git_prompt_info)$(hg_prompt_info)'
local venv_name=""
if [[ -n $VIRTUAL_ENV ]]; then
  venv_name="%{$fg_bold[cyan]%}$(basename $VIRTUAL_ENV)%{$reset_color%} %{$fg[white]%}|%{$reset_color%}"
fi

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─${date_time}${user_host}${current_dir}${git}${venv_name}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}%{$fg[white]%}|%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%}"
