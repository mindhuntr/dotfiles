#!/usr/bin/env bash 

if [[ -n "$(pgrep waybar)" ]] 
then
    killall waybar
fi 

waybar >/dev/null 2>&1 & disown 
