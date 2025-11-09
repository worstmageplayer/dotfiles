#!/usr/bin/env bash

mkdir -p ~/screenshots

output=~/screenshots/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png

grim -g "$(slurp)" "$output"
wl-copy < "$output"
