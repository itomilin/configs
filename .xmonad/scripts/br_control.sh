#/usr/bin/env bash

cmd=$1
min=0
max=`cat /sys/class/backlight/intel_backlight/max_brightness`

if [[ $cmd == "down" ]]
then
    new=$(( `cat /sys/class/backlight/intel_backlight/brightness` - 20 ))
    echo $new > /sys/class/backlight/intel_backlight/brightness
elif [[ $cmd == "up" ]]
then
    new=$(( `cat /sys/class/backlight/intel_backlight/brightness` + 20 ))
    echo $new > /sys/class/backlight/intel_backlight/brightness
else
    printf "%s\n" "Unhadled cmd."
fi

