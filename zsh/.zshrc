# Created by newuser for 5.9
autoload -U colors && colors
LAST_PROMPT_DIR=""
PROMPT="%{$fg[red]%}  %{$reset_color%}"

function prompt_precmd() {
    local currentDir=$PWD
    local width=$COLUMNS  # Get terminal width

    if [[ "$currentDir" != "$LAST_PROMPT_DIR" ]]; then
        LAST_PROMPT_DIR=$currentDir

        local lineLength=$(( width - ${#currentDir} - 4 ))
        local equals=$(printf ""%.0s {1..$lineLength})

        local dirColor="%{%F{111}%}"   # Directory color
        local lineColor="%{%F{8}%}"    # Line color
        local reset="%{%f%}"           # Reset color

        print -P "${lineColor} ${dirColor}%B$currentDir%B${reset} ${lineColor}$equals${reset}"
    fi
}

precmd() {
    prompt_precmd
}
