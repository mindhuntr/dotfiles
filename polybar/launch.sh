#!/bin/bash

killall -q polybar

polybar --config=~/.config/polybar/config.ini complete >/dev/null 2>&1 | tee -a /tmp/polybar.log & disown
# polybar --config=~/.config/polybar/config.ini left 2>&1 &
# polybar --config=~/.config/polybar/config.ini center 2>&1 &

echo "Polybar launched."
