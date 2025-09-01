#!/usr/bin/env bash 


toggle() { 
    makoctl mode -t do-not-disturb
} 
status() {
    if [[ -n "$(makoctl mode)" ]]; then
        echo '{"text": " ", "tooltip": "Do Not Disturb On", "class": "enabled"}'
    else
        echo '{"text": " ", "tooltip": "Do Not Disturb Off", "class": "disabled"}'
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
