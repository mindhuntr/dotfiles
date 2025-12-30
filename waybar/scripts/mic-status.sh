#!/bin/bash

# Get mute status
STATUS=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
VOLUME=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk '/Volume:/ {print $5}')

if [ "$STATUS" = "yes" ]; then
    echo '{"text": " ", "tooltip": "Microphone muted", "class": "muted"}'
else
echo "{\"text\": \" $VOLUME\",\"tooltip\": \"Microphone active\", \"class\": \"unmuted\"}"
fi

