#!/usr/bin/env bash

mkdir -p ~/screenshots

output=~/screenshots/$(hyprctl activewindow -j | jq -r '.class' | tr ' ' '_')-$(date +'%Y-%m-%d_%H-%M-%S').png

grim -g "$(slurp -b 00000080 -c ffffffff -w 1)" "$output"
wl-copy < "$output"
