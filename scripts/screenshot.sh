#!/usr/bin/env bash

mkdir -p ~/screenshots

title=$(hyprctl activewindow -j | jq -r '.title')
timestamp=$(date +'%Y-%m-%d_%H-%M-%S')
output="$HOME/screenshots/${title}-${timestamp}.png"

grim -g "$(slurp -b 00000080 -c ffffffff -w 1)" "$output"
wl-copy < "$output"
