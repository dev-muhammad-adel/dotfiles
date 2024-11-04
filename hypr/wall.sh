#!/bin/bash

swww-daemon &
BACK_PID=$!
wait $BACK_PID
swww img ~/.config/assets/backgrounds/cat_leaves.png  --transition-fps 255 --transition-type outer --transition-duration 0.8