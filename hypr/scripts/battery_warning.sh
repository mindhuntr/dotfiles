#!/bin/bash
# @requires: mplayer, brightnessctl

iconpath="/home/mindhunter/.config/hypr/notify_icons"
# Delay for startup
sleep 5

sendNotification() {
    local message="$1"
    notify-send -e -u critical "Battery Low!" "$message" -i $iconpath/battery-alert.png
}

notify_count=0

while true; do
    Battery_Status="$(cat /sys/class/power_supply/BAT*/status)"
    Battery_Capacity=$(cat /sys/class/power_supply/BAT*/capacity)

    if [ "$Battery_Status" == "Discharging" ] && [ "$Battery_Capacity" -le 25 ]; then
        if [ "$notify_count" -eq 0 ]; then
            sendNotification "Power running out: <b>${Battery_Capacity}%</b>"
            notify_count=$((notify_count + 1))
            sleep 180

        elif [ "$notify_count" -eq 1 ]; then
            sendNotification "<b>Save your works</b> before immediate shutdown."
            notify_count=$((notify_count - 1))
            sleep 180
        fi
    else
        notify_count=0
        sleep 120
    fi
done
