#!/usr/bin/env bash 


toggle() { 
    if [[ "$(makoctl mode)" == "default" ]]; then
        makoctl mode -r default
        makoctl mode -s do-not-disturb 
    else
        makoctl mode -r do-not-disturb
        makoctl mode -s default
    fi
} 
status() {
    if [[ "$(makoctl mode)" == "default" ]]; then
        echo '{"text": " ", "tooltip": "Do Not Disturb Off", "class": "disabled"}'
    else
        echo '{"text": " ", "tooltip": "Do Not Disturb On", "class": "enabled"}'
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
