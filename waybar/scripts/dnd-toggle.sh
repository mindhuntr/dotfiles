#!/usr/bin/env bash 

iconpath="/home/mindhunter/.config/hypr/notify_icons"

toggle() { 
    if [[ "$(makoctl mode)" == "default" ]]; then
        notify-send -c "system-notification" -u low "DND On" -t 1000 -r 9825 --icon=$iconpath/bell-off.png
        makoctl mode -a do-not-disturb 
        dms ipc call notifications toggleDoNotDisturb
    else
        makoctl mode -r do-not-disturb
        notify-send -c "system-notification" -u low "DND Off" -t 1000 -r 9825 --icon=$iconpath/bell-ring.png
        dms ipc call notifications toggleDoNotDisturb
    fi
} 
status() {
    if [[ "$(makoctl mode)" == "default" ]]; then
        echo '{"text": "  ", "tooltip": "Do Not Disturb Off", "class": "disabled"}'
    else
        echo '{"text": "  ", "tooltip": "Do Not Disturb On", "class": "enabled"}'
    fi
}

case "$1" in
    toggle)
        toggle
        ;;
    status)
        status
        ;;
esac
