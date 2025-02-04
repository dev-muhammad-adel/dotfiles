
#!/bin/sh

RESIZE_SIZE=${1:?Missing resize size}

RESIZE_PARAMS_X=0
RESIZE_PARAMS_Y=0

DIRECTION=${2:?Missing move direction}
case $DIRECTION in
l)
	RESIZE_PARAMS_X=-$RESIZE_SIZE
	;;
r)
	RESIZE_PARAMS_X=$RESIZE_SIZE
	;;
u)
	RESIZE_PARAMS_Y=-$RESIZE_SIZE
	;;
d)
	RESIZE_PARAMS_Y=$RESIZE_SIZE
	;;
*)
	echo "kbye"
	return 1
	;;
esac

ACTIVE_WINDOW=$(hyprctl activewindow -j)
IS_FLOATING=$(echo "$ACTIVE_WINDOW" | jq .floating)

if [ "$IS_FLOATING" = "true" ]; then
	hyprctl dispatch moveactive "$RESIZE_PARAMS_X" "$RESIZE_PARAMS_Y"
else
	hyprctl dispatch swapsplit "$DIRECTION"
fi