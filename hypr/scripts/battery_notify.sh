#!/bin/bash

iconpath="/home/mindhunter/.config/hypr/notify_icons"

# Delay for startup
sleep 5

# Change your sound path here
#
adjustBrightness() {
    local adjustment="$1"
    brightnessctl set "$adjustment"
}

sendNotification() {
    local title="$1"
    local message="$2"
    local icon=$iconpath/${3}.png
    notify-send -i "$icon" -u low -t 2000 -r 9825 -c system-notification "$title" "\n$message"
}

# Runs full time in background
x=0
while true; do
    Battery_Status="$(cat /sys/class/power_supply/BAT*/status)"
    Battery_Capacity=$(cat /sys/class/power_supply/BAT*/capacity)

    case "$Battery_Status" in
        "Discharging")
            if [ $x -eq 1 ]; then
                sendNotification "Discharging" "Remains: <b>${Battery_Capacity}%</b>" "battery-discharging"
                # adjustBrightness "15%-"
                # playsound
                x=0
            fi
            ;;
        "Charging")
            if [ $x -eq 0 ]; then
                sendNotification "Charging" "Current: <b>${Battery_Capacity}%</b>" "battery-charging"
                # adjustBrightness "15%+"
                x=1
            fi
            ;;
        "Full")
            if [ $x -eq 0 ]; then
                sendNotification "Fully Charged" "Noice: <b>${Battery_Capacity}%</b>" "battery-full"
                x=1
            fi
            ;;
    esac

    sleep 1
done
