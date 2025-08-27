#!/bin/bash

current=$(hyprctl activeworkspace -j | jq -r '.id')
target=$1

if [ "$current" -eq "$target" ]; then
    hyprctl dispatch workspace previous
else
    hyprctl dispatch workspace $target
fi

