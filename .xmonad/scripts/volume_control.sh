#!/usr/bin/env bash
set -e

MODE=$1
if [[ -z $MODE ]]; then
    exit 1
fi

PATH_TO_PIPE="/home/$USER/.xmonad/scripts/volume-info"
#getMaster=$( /usr/bin/amixer -c 0 get Master,0 | `
#            `/usr/bin/awk 'END{print $6,$4}' | tr -d '[]' )

CURRENT_STATE=`/usr/bin/amixer -c 0 get Master,0 | grep -Po "Playback.+\[\K([a-z]{2,3})"`

if [[ $MODE == "TOGGLE" ]]; then
    if [[ $CURRENT_STATE == "on" ]]; then
        /usr/bin/amixer set Master    mute
        /usr/bin/amixer set Headphone mute
        CURRENT_STATE="off"
    else
        /usr/bin/amixer set Master    unmute
        /usr/bin/amixer set Speaker   unmute
        /usr/bin/amixer set Headphone unmute
        CURRENT_STATE="on"
    fi
elif [[ $MODE == "UP" ]]; then
    /usr/bin/amixer -c 0 -- sset Master playback 2%+
elif [[ $MODE == "DOWN" ]]; then
    /usr/bin/amixer -c 0 -- sset Master playback 2%-
fi

VOLUME=`/usr/bin/amixer get Master | grep -Po "Playback.+\[\K([0-9]{1,3}%)"`

echo "${CURRENT_STATE} ${VOLUME}" > $PATH_TO_PIPE # Update info to status bar.

