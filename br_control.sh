#/usr/bin/env bash

cmd=$1

if [[ $cmd == "down" ]]
then
    current_br=$(( `cat /sys/class/backlight/intel_backlight/brightness` - 10 ))
    echo $current_br > /sys/class/backlight/intel_backlight/brightness
elif [[ $cmd == "up" ]]
then
    current_br=$(( `cat /sys/class/backlight/intel_backlight/brightness` + 10 ))
    echo $current_br > /sys/class/backlight/intel_backlight/brightness
else
    printf "%s\n" "Unhadled cmd."
fi

