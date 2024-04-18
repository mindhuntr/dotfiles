#!/bin/bash

killall -q polybar

polybar --config=~/.config/polybar/config.ini complete 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched."
