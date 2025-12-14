export PATH=~/dotfiles/scripts/:$PATH
export LC_ALL=en_US.UTF-8
autoload -U colors && colors

typeset -A color
color[dir]="%{%F{111}%}"
color[icon]="%{%F{8}%}"

typeset -g LAST_PROMPT_DIR=""
typeset -g PROMPT_DIR_LINE=""

function prompt_precmd() {
    if [[ "$PWD" != "$LAST_PROMPT_DIR" ]]; then
        LAST_PROMPT_DIR=$PWD
        PROMPT_DIR_LINE="${color[icon]}%{%G%} ${color[dir]}%B${PWD}%b%{%f%}
"
    else
        PROMPT_DIR_LINE=""
    fi

    PROMPT="${PROMPT_DIR_LINE}%{$fg[red]%} %{%G%} %{$reset_color%}"
}

precmd_functions+=(prompt_precmd)

command_not_found_handler() {
  command="$1"
  echo "Command '$command' not found!" | cowsay -f actually
}
