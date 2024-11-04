#!/bin/bash


# Check if a value was provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <decrease_value>"
    exit 1
fi

# Get the decrease value from the first argument
DECREASE_VALUE=$1



CURRENT=$(cat /sys/class/leds/:white:kbd_backlight/brightness)
MAX=$(cat /sys/class/leds/:white:kbd_backlight/max_brightness)

NEW_BRIGHTNESS=$((CURRENT - DECREASE_VALUE))
if [ "$NEW_BRIGHTNESS" -lt 0 ]; then
    NEW_BRIGHTNESS=0
fi
echo "$NEW_BRIGHTNESS" | sudo tee /sys/class/leds/:white:kbd_backlight/brightness
BRIGHTNESS_PERCENTAGE=$((NEW_BRIGHTNESS * 100 / MAX))

notify-send -r 111  -a " Backlight"  "Keyboard backlight: $BRIGHTNESS_PERCENTAGE%"  -h  int:value:"$BRIGHTNESS_PERCENTAGE"


