#!/bin/bash

# File to store the last brightness value
LAST_BRIGHTNESS_FILE="/tmp/last_kbd_brightness"

# Read the current brightness and maximum brightness
CURRENT=$(cat /sys/class/leds/:white:kbd_backlight/brightness)
MAX=$(cat /sys/class/leds/:white:kbd_backlight/max_brightness)

# Function to set brightness and notify
set_brightness() {
    local NEW_BRIGHTNESS=$1
    echo "$NEW_BRIGHTNESS" | sudo tee /sys/class/leds/:white:kbd_backlight/brightness > /dev/null
   # BRIGHTNESS_PERCENTAGE=$((NEW_BRIGHTNESS * 100 / MAX))
   # notify-send -r 111 -a "Backlight" "Keyboard backlight: $BRIGHTNESS_PERCENTAGE%" -h int:value:"$BRIGHTNESS_PERCENTAGE"
}

# Process commands
case "$1" in
    save)
        echo "$CURRENT" > "$LAST_BRIGHTNESS_FILE"
        echo "Saved current brightness: $CURRENT"
        ;;
    restore)
        if [ -f "$LAST_BRIGHTNESS_FILE" ]; then
            VALUE=$(cat "$LAST_BRIGHTNESS_FILE")
            set_brightness "$VALUE"
        else
            echo "No saved brightness found."
            exit 1
        fi
        ;;
    set)
        if [ $# -ne 2 ]; then
            echo "Usage: $0 set <value>"
            exit 1
        fi
        NEW_BRIGHTNESS=$2  # Correctly get the value from the second argument
        if [ "$NEW_BRIGHTNESS" -lt 0 ]; then
            NEW_BRIGHTNESS=0
        elif [ "$NEW_BRIGHTNESS" -gt "$MAX" ]; then
            NEW_BRIGHTNESS=$MAX    
        fi
        echo "$CURRENT" > "$LAST_BRIGHTNESS_FILE"  # Save current before changing
        set_brightness "$NEW_BRIGHTNESS"
        ;;
    *)
        echo "Invalid command. Use 'save', 'restore', or 'set'."
        exit 1
        ;;
esac
