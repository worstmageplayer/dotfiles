autoload -U colors && colors

typeset -A color
color[dir]="%{%F{111}%}"
color[icon]="%{%F{8}%}"

typeset -g LAST_PROMPT_DIR=""

function prompt_precmd() {
    if [[ "$PWD" != "$LAST_PROMPT_DIR" ]]; then
        LAST_PROMPT_DIR=$PWD
        local dir_prompt="${color[icon]}  ${color[dir]}%B${PWD}"
        print -P "$dir_prompt"
    fi
}

precmd_functions+=(prompt_precmd)

PROMPT="%{$fg[red]%}  %{$reset_color%}"
