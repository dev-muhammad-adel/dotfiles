
#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <INcrease_value>"
    exit 1
fi

# Get the decrease value from the first argument
INCREASE_VALUE=$1


CURRENT=$(cat /sys/class/leds/:white:kbd_backlight/brightness)
MAX=$(cat /sys/class/leds/:white:kbd_backlight/max_brightness)
NEW_BRIGHTNESS=$((CURRENT + INCREASE_VALUE))
if [ "$NEW_BRIGHTNESS" -gt "$MAX" ]; then
    NEW_BRIGHTNESS="$MAX"
fi
echo "$NEW_BRIGHTNESS" | sudo tee /sys/class/leds/:white:kbd_backlight/brightness

BRIGHTNESS_PERCENTAGE=$((NEW_BRIGHTNESS * 100 / MAX))

# Use $BRIGHTNESS_PERCENTAGE instead of BRIGHTNESS_PERCENTAGE
notify-send -r 111  -a " Backlight"  "Keyboard backlight : $BRIGHTNESS_PERCENTAGE%"  -h  int:value:"$BRIGHTNESS_PERCENTAGE"
 
