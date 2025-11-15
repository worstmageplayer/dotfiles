autoload -U colors && colors

typeset -A color
color[dir]="%{%F{111}%}"
color[icon]="%{%F{8}%}"

typeset -g LAST_PROMPT_DIR=""
typeset -g PROMPT_DIR_LINE=""

function prompt_precmd() {
    if [[ "$PWD" != "$LAST_PROMPT_DIR" ]]; then
        LAST_PROMPT_DIR=$PWD
        PROMPT_DIR_LINE="${color[icon]}  ${color[dir]}%B${PWD}%b
"
    else
        PROMPT_DIR_LINE=""
    fi

    # MULTILINE prompt, safe handling by zsh
    PROMPT="${PROMPT_DIR_LINE}%{$fg[red]%}  %{$reset_color%}"
}
precmd_functions+=(prompt_precmd)
