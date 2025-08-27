#!/bin/bash

# Get mute status
STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')

if [ "$STATUS" = "yes" ]; then
    echo '{"text": "", "tooltip": "Microphone muted", "class": "muted"}'
else
    echo '{"text": "", "tooltip": "Microphone active", "class": "unmuted"}'
fi

