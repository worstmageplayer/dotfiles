#!/usr/bin/env bash

mkdir -p /tmp/screenshots

title=$(
    hyprctl activewindow -j |
    jq -r '.title' |
    sed 's#[/\\:*?"<>|]#_#g'
)
timestamp=$(date +'%Y-%m-%d_%H-%M-%S')
output="/tmp/screenshots/${timestamp}-${title}.png"

grim -g "$(slurp -b 00000080 -c ffffffff -w 1)" "$output"
wl-copy < "$output"
